require 'tidy_strong_params/resource'

module TidyStrongParams
  module Controller # :nodoc:
    extend ActiveSupport::Concern
    module ClassMethods # :nodoc:
      def inherited(klass)
        super
        resource = Resource.new(controller_class: klass.name)
        return if method_defined?(resource.prams_method_name)
        define_method(resource.prams_method_name) do
          resource.strong_params_class.build_list(
            raw_params: params,
            resource_name: resource.name
          )
        end
      end
    end
  end
end
