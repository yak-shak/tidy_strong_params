# TidyStrongParams

Strong params can end up making your controllers very fat and form objects aren't always the best cure.
Tidy Strong Params (TSP) takes inspiration from ActiveModelSerialiers and aims to separate param white-listing from the rest of your controller logic whilst also allowing for flexibility in it's implementation.

TSP provides a simple way for storing your list of white-listed params in their own directory, hopefully with minimal overhead.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tidy_strong_params'
```

## Usage

#### Overview

Create a params directory and create a params class inheriting from `TidyStrongParams::StrongParams` for each whitelist

```
class BookStrongParams < TidyStrongParams::StrongParams
  params  :tile,
          :publisher,
          :year,
          authors: %i[first_name last_name]
end
```

A `tidy_strong_parms` method is available on each controller which returns the whitelisted params defined by its corresponding StrongParms class. eg. BookStrongParams for the books controller

```
Class BooksController < ApplicationController
  def update
    @book.update(tidy_strong_params)
  end
end
```

#### `TidyStrongParams::StrongParams`
##### `params` (Class method)

The `params` helper method takes the list of parameters you would usually pass as arguments to `permit()` in your controller.

##### params (instance method)

The params class method above is the simplest and cleanest way to pass a list of permitted attributes. However if you require more control eg. (conditionally permit params) then you can define your own `params` instance method which should return an array of permitted attributes. eg.

```
class BookStrongParams < TidyStrongParams::StrongParams
  def params
    [
      :tile,
      publisher
    ]
  end

  def publisher
    :publisher if raw_params[:book][:publisher] == 'Faber&Faber'
  end
end
```

It overrides anything built using the `params` class method 

##### `required` (Class method)
By default params are required to be nested under their resource name. eg. for the books controller it would be equivalent of calling `params.require(:books)`. The name of this required parameter can be changed of disabled (pass false) using the `required` class method.

```
class BookStrongParams < TidyStrongParams::StrongParams
  required :old_books
  params  :tile,
          :publisher
end

expects `{ old_books: { tile: "", publisher: ''} }`
```

##### `tap_params` (instance method)

Allows you to tap into and tweak the list of permitted attributes before they are returned. The main difference between this and the params instance method, is this method is called after `require` and can be used in conjunction with the `params` class helper.

```
class BookStrongParams < TidyStrongParams::StrongParams
  params  :tile,
          :publisher

  def tap_params(whitelist)
    whitelist[:authors] = ['tom', 'dick', 'harry'] unless whitelist[:authors]
    whitelist[:request_meta] = raw_params[:book].keys.length
  end
end
```


##### `restrict` (class method)
Although a `tidy_strong_params` method is injected into each controller the `TidyStrongParams::StrongParams` class can be used directly, just pass in the required `raw_params` argument to the `restrict` method.
Note `resource_name` is only needed if there is no `required` key declared on the BookStrongParams class. Scope is optional

```
Class BooksController < ApplicationController
  tidy_params_scope :current_user

  def create
    Book.create(CreateBookStrongParams.restrict(raw_params: params, scope: current_user))
  end

  def update
    @book.update(UpdateBookStrongParams.restrict(raw_params: params, resource_name: 'book'))
  end
end
```


#### `tidy_params_scope` (Class method added to controllers)

As scope for TSP can be set at the controller level which is then passed to the `StrongParams` class. Useful for passing things like `current_user`. If the same scope is used everywhere then may best to set `tidy_params_scope` on the `ApplicationController`.

```
Class BooksController < ApplicationController
  tidy_params_scope :current_user

  def update
    @book.update(tidy_strong_params)
  end
end
```
Then scope can be assessed as an attribute in the StrongParams class

```
class BookStrongParams < TidyStrongParams::StrongParams
  params  :tile,
          :publisher

  def tap_params(whitelist)
    whitelist.delete(:tile) = unless scope.current_user&.admin?
    whitelist[:user_id] = scope.current_user&.id
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/tidy_strong_params. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the TidyStrongParams project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/tidy_strong_params/blob/master/CODE_OF_CONDUCT.md).
