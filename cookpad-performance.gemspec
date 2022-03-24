require_relative "lib/cookpad/performance/version"

Gem::Specification.new do |spec|
  spec.name        = "cookpad-performance"
  spec.version     = Cookpad::Performance::VERSION
  spec.authors     = ["Bodacious"]
  spec.email       = ["gavin@gavinmorrice.com"]
  spec.homepage    = "https://github.com/cookpad/cookpad-performance"
  spec.summary     = "Rails app performance tools"
  spec.description = "Provides a set of performance tools for our Rails apps"
    spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{config,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "prosopite", "~> 1.0.8"
  spec.add_dependency "rails", ">= 7.0.2.3", "< 8"
  spec.add_dependency "rack-mini-profiler", "~> 2.3.3"
  spec.add_development_dependency "byebug", "~> 11.1.3"
  spec.add_development_dependency "rspec", "~> 3.10.0"
  spec.add_development_dependency "rubocop", "~> 1.26.0"
  spec.add_development_dependency "rubocop-rspec", "~> 2.9.0"
  spec.add_development_dependency "rubocop-rails", "~> 2.13.2"
  spec.add_development_dependency "rubocop-performance", "~> 1.13.3"
  spec.add_development_dependency "sprockets"
  spec.add_development_dependency "uglifier"
end
