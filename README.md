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

Create a params directory and create a params class inherting from `TidyStrongParams::StrongParams` for each whitelist

```
class BookParams < TidyStrongParams::StrongParams
  attributes  :tile
              :publisher,
              :year,
              authors: %i[first_name last_name]
end
```

A parms method is created on each controller taking the resource name from the controller. eg. in the following example a `book_params` method is created and can be called by the controller.

```
Class BooksController < ApplicationController
    def update
        @book.update(book_params)
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
