module TidyStrongParams
  class Resource
    attr_accessor :controller_class, :safe_params_class
   
    def initialize(controller_class:)
      self.controller_class = controller_class
    end

    def self.prams_method_name(controller_class:)
      new(controller_class: controller_class).prams_method_name
    end

    def name
      params_class_name.underscore
    end

    def prams_method_name
      "#{name}_params"
    end

    def safe_params_class
      return @safe_params_class if @safe_params_class
      klass = "::#{params_class_name}SafeParams".safe_constantize
      @safe_params_class = klass || TidyStrongParams::SafeParams
    end

    private

    def params_class_name
      controller_class.remove("Controller").singularize
    end
  end
end