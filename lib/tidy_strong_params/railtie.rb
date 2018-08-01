require 'rails/railtie'
require 'tidy_strong_params/controller'

module TidyStrongParams
  class Railtie < Rails::Railtie # :nodoc:
    initializer 'tidy_strong_params.action_controller' do
      ActiveSupport.on_load(:action_controller) do
        include(TidyStrongParams::Controller)
      end
    end
  end
end
