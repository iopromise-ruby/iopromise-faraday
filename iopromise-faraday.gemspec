# frozen_string_literal: true

require_relative "lib/iopromise/faraday/version"

Gem::Specification.new do |spec|
  spec.name          = "iopromise-faraday"
  spec.version       = IOPromise::Faraday::VERSION
  spec.authors       = ["Theo Julienne"]
  spec.email         = ["theo.julienne@gmail.com"]

  spec.summary       = "Parallel Faraday support via IOPromise"
  spec.description   = "This gem provides a promise-based interface to Faraday using IOPromise"
  spec.homepage      = "https://github.com/iopromise-ruby/iopromise-faraday"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'iopromise', '~> 0.1.2'

  # we pin these very specifically while we are monkey patching support
  spec.add_dependency 'faraday', '1.4.2'
  spec.add_dependency 'typhoeus', '1.4.0'
  spec.add_dependency 'ethon', '0.14.0'
end
