lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastlane/plugin/setapp/version'

Gem::Specification.new do |spec|
  spec.name          = 'fastlane-plugin-setapp'
  spec.version       = Fastlane::Setapp::VERSION
  spec.author        = 'Setapp Limited'
  spec.email         = 'developers@setapp.com'
  spec.summary       = 'Upload new version to Setapp'
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*"] + %w(README.md LICENSE)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.6'
  spec.add_development_dependency('bundler')
  spec.add_development_dependency('fastlane', '>= 2.211.0')
  spec.add_development_dependency('pry')
  spec.add_development_dependency('rake')
  spec.add_development_dependency('rspec')
  spec.add_development_dependency('rspec_junit_formatter')
  spec.add_development_dependency('rubocop', '1.12.1')
  spec.add_development_dependency('rubocop-performance')
  spec.add_development_dependency('rubocop-require_tools')
  spec.add_development_dependency('simplecov')
end
