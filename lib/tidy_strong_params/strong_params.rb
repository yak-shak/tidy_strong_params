module TidyStrongParams
  class StrongParams # :nodoc:
    class_attribute :_params
    class_attribute :_required
    self._params = {}
    self._required = nil

    attr_accessor :raw_params, :resource_name, :scope

    def initialize(raw_params:, resource_name: '', scope: nil)
      self.raw_params = raw_params
      self.resource_name = resource_name
      self.scope = scope
    end

    def self.restrict(*args)
      new(*args).restrict
    end

    class << self
      def params(*attrs)
        self._params = attrs
      end

      def required(required)
        self._required = required
      end
    end

    def params
      _params
    end

    def restrict
      required_params.permit(params).to_h.tap{ |whitelist| tap_params(whitelist) }
    end

    private

    def required_params
      return raw_params if _required == false
      raw_params.require(_required || resource_name)
    end

    def tap_params(whitelist)
    end
  end
end
