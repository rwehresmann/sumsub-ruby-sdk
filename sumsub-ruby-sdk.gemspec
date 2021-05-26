# frozen_string_literal: true

require_relative "lib/sumsub/version"

Gem::Specification.new do |spec|
  spec.name          = "sumsub-ruby-sdk"
  spec.version       = Sumsub::VERSION
  spec.authors       = ["Rodrigo W. Ehresmann"]
  spec.email         = ["igoehresmann@gmail.com"]

  spec.summary       = "SumSub Ruby SDK"
  spec.description   = "SDK written in Ruby to handle with SumSub API."
  spec.homepage      = "https://github.com/rwehresmann/sumsub-ruby-sdk"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/rwehresmann/sumsub-ruby-sdk"
  spec.metadata["changelog_uri"] = "https://github.com/rwehresmann/sumsub-ruby-sdk"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html

  spec.add_dependency "http", "~> 5.0.0"
  spec.add_dependency "dry-struct", "~> 1.4.0"
  spec.add_dependency "rspec", "~> 3.10.0"
  spec.add_dependency "pry", "~> 0.14.1"
  spec.add_dependency "webmock", "~> 3.13.0"
  spec.add_dependency "timecop", "~> 0.9.4"
  spec.add_dependency "mime-types", "~> 3.3.1"
end
