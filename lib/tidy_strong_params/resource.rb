module TidyStrongParams
  class Resource # :nodoc:
    attr_accessor :controller_class

    def initialize(controller_class:)
      self.controller_class = controller_class
    end

    def name
      resource.split('::').last.underscore
    end

    def strong_params_class
      return @strong_params_class if @strong_params_class
      klass = "::#{params_class_name}".safe_constantize
      raise Errors::StrongParamsClassUndefinedError.new(params_class_name) unless klass
      @strong_params_class = klass
    end

    private

    def resource
      controller_class.remove('Controller').singularize
    end

    def params_class_name
      "#{resource}StrongParams"
    end
  end
end
