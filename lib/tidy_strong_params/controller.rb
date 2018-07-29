require 'tidy_strong_params/resource'

module TidyStrongParams
  module Controller
    extend ActiveSupport::Concern
    included do |base|
      def initialize
        name = self.class.name
        self.instance_eval %Q"
          def #{::TidyStrongParams::Resource.prams_method_name(controller_class: name)}
            resource = ::TidyStrongParams::Resource.new(controller_class: self.class.name)
            safe_params_class = resource.safe_params_class.new(params, resource_name: resource.name)
            safe_params_class.build_list
          end
        "
        super
      end
    end
  end
end
