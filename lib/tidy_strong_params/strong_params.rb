module TidyStrongParams
  class StrongParams # :nodoc:
    class_attribute :_attributes
    class_attribute :_required
    self._attributes = {}
    self._required = nil

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

      def required(required)
        self._required = required
      end
    end

    def build_list
      required_params.permit(_attributes).to_h
    end

    def required_params
      return raw_params if _required == false
      raw_params.require(_required || resource_name)
    end
  end
end
