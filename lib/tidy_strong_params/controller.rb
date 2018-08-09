require 'tidy_strong_params/resource'

module TidyStrongParams
  module Controller # :nodoc:
    extend ActiveSupport::Concern

    included do
      class_attribute :_tidy_params_scope
    end
    
    module ClassMethods  
      def tidy_params_scope(scope)
        self._tidy_params_scope = scope
      end
    end

    def tidy_params_scope
      send(_tidy_params_scope) if _tidy_params_scope &&
                                  respond_to?(_tidy_params_scope, true)
    end

    define_method(:tidy_params) do
      resource = Resource.new(controller_class: self.class.name)
      resource.strong_params_class.restrict(
        raw_params: params,
        resource_name: resource.name,
        scope: tidy_params_scope
      )
    end
  end
end
