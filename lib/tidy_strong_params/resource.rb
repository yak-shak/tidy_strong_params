module TidyStrongParams
  class Resource
    attr_accessor :resource
   
    def initialize(resource)
      self.resource
    end
   
    def self.prams_method_name(resource)
      new(resource).send(:prams_method_name)
    end

    private

    def prams_method_name
      "#{determine_name}_params"
    end

    def determine_name
      "boulle"
    end
  end
end