module TidyStrongParams
  module Errors 
    class StrongParamsClassUndefinedError < StandardError
      attr_reader :resource_class_name
      
      def initialize(resource_class_name)
        @resource_class_name = resource_class_name
      end

      def to_s
        "A #{resource_class_name} class has not been defined"
      end
    end
  end
end