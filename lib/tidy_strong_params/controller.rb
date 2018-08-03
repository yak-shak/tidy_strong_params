require 'tidy_strong_params/resource'

module TidyStrongParams
  module Controller # :nodoc:
    extend ActiveSupport::Concern

        define_method(:tidy_params) do
          resource = Resource.new(controller_class: self.class.name)
          resource.strong_params_class.build_list(
            raw_params: params,
            resource_name: resource.name
          )
        end

  end
end
