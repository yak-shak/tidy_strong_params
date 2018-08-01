module TidyStrongParams
  class Resource
    attr_accessor :controller_class, :strong_params_class
   
    def initialize(controller_class:)
      self.controller_class = controller_class
    end

    def self.prams_method_name(*args)
      new(*args).prams_method_name
    end

    def name
      params_class_name.underscore
    end

    def prams_method_name
      "#{name}_params"
    end

    def strong_params_class
      return @strong_params_class if @strong_params_class
      klass = "::#{params_class_name}StrongParams".safe_constantize
      @strong_params_class = klass || TidyStrongParams::StrongParams
    end

    private

    def params_class_name
      controller_class.remove("Controller").singularize
    end
  end
end
