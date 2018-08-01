module TidyStrongParams
  class StrongParams # :nodoc:
    class_attribute :_attributes
    self._attributes = {}
    attr_accessor :raw_params, :resource_name

    def initialize(raw_params:, resource_name:)
      self.raw_params = raw_params
      self.resource_name = resource_name
    end

    def self.build_list(*args)
      new(*args).build_list
    end

    class << self
      def attributes(*attrs)
        self._attributes = attrs
      end
    end

    def build_list
      raw_params.require(root_name).permit(_attributes).to_h
    end

    def root_name
      resource_name
    end
  end
end
