require 'bundler/setup'
require 'rails'
require 'rails/test_help'
require 'tidy_strong_params'
require 'simplecov'
SimpleCov.start

ENV['RAILS_ENV'] = 'test'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  # Dummy Railtie initializer hook in favor of creating dummy rails app
  TidyStrongParams::Railtie.initializers.each(&:run)

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
