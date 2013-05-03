# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'places/version'

Gem::Specification.new do |spec|
  spec.name          = "places"
  spec.version       = Places::VERSION
  spec.summary       = "Earlydoc healthcare places"
  spec.description   = "This gem provides the models and web-scraping tools for healthcare-specific points of interest."
  spec.authors       = ['Earlydoc', 'Travis Dunn']
  spec.email         = 'developer@earlydoc.com'
  spec.homepage      = 'https://www.earlydoc.com'
  spec.license       = "MIT"
  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_dependency 'mongoid', "~> 4.0"
  spec.add_dependency 'activesupport', '~> 4.0.0.rc1'
end
