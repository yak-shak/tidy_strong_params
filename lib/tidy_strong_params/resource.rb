module TidyStrongParams
  class Resource # :nodoc:
    attr_accessor :controller_class

    def initialize(controller_class:)
      self.controller_class = controller_class
    end

    def name
      params_class_name.underscore
    end

    def strong_params_class
      return @strong_params_class if @strong_params_class
      klass = "::#{params_class_name}StrongParams".safe_constantize
      @strong_params_class = klass || TidyStrongParams::StrongParams
    end

    private

    def params_class_name
      controller_class.remove('Controller').singularize
    end
  end
end
