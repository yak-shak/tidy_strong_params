require 'tidy_strong_params/resource'

module TidyStrongParams
  module Controller
    extend ActiveSupport::Concern
    
    define_method ::TidyStrongParams::Resource.prams_method_name(self) do
      puts 'hello ima gem'
    end
  end
end
