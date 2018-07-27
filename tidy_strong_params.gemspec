
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "tidy_strong_params/version"

Gem::Specification.new do |spec|
  spec.name          = "tidy_strong_params"
  spec.version       = TidyStrongParams::VERSION
  spec.authors       = ["Jonny Wheeler"]
  spec.email         = ["jonny@yakshak.co.uk"]

  spec.summary       = %q{Tidies up after your strong params}
  spec.description   = %q{ Strong params can endup making your contollers very fat and form objects arn't always the best cure.
                           Tidy Strong Params (TSP) takes inspiration from ActiveModelSerialiers
                           and aims to seperate param whitelisting from the rest of your controller logic
                           whilst also allowing for flexibility in it's implemntation.
                           TSP provides a simple way for storing your list of whitlisted parsms in their own directory,
                           hopefully with minimal overhead }
  spec.homepage      = "http://DO-THIS.com"
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

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
