require_relative "lib/cookpad/performance/version"

# rubocop:disable Metrics/BlockLength
Gem::Specification.new do |spec|
  spec.name        = "cookpad-performance"
  spec.version     = Cookpad::Performance::VERSION
  spec.authors     = ["Cookpad Inc."]
  spec.email       = ["kaihatsu@cookpad.com"]
  spec.homepage    = "https://github.com/cookpad/cookpad-performance"
  spec.summary     = "Rails app performance tools"
  spec.description = "Provides a set of performance tools for our Rails apps"
  spec.license = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{config,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end
  spec.required_ruby_version = ">= 2.7.0"

  spec.add_dependency "prosopite", "~> 1.0"
  spec.add_dependency "rails", ">= 6.1"

  spec.add_development_dependency "byebug", "~> 11.1"
  spec.add_development_dependency "pronto", "~> 0.11"
  spec.add_development_dependency "pronto-rubocop", "~> 0.11"
  spec.add_development_dependency "rspec", "~> 3.10"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "rubocop", "~> 1.26"
  spec.add_development_dependency "rubocop-performance", "~> 1.13"
  spec.add_development_dependency "rubocop-rails", "~> 2.13"
  spec.add_development_dependency "rubocop-rspec", "~> 2.9"
  spec.add_development_dependency "sprockets-rails"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "uglifier", "~> 4.2"
  spec.metadata["rubygems_mfa_required"] = "true"
end
# rubocop:enable Metrics/BlockLength
