
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "tidy_strong_params/version"

Gem::Specification.new do |spec|
  spec.name          = "tidy_strong_params"
  spec.version       = TidyStrongParams::VERSION
  spec.authors       = ["Jonny Wheeler"]
  spec.email         = ["jonny@yakshak.co.uk"]

  spec.summary       = %q{Tidies up after your strong params}
  spec.description   = %q{ Strong params can end up making your controllers very fat and form objects aren't always the best cure.
                           Tidy Strong Params (TSP) takes inspiration from ActiveModelSerialiers
                           and aims to separate param white-listing from the rest of your controller logic
                           whilst also allowing for flexibility in it's implementation.
                           TSP provides a simple way for storing your list of white-listed params in their own directory,
                           hopefully with minimal overhead }
  spec.homepage      = "https://github.com/yak-shak/tidy_strong_params"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = 'http://mygemserver.com'
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rails", ">= 5"
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency 'rspec-rails', "~> 3.0"
end
