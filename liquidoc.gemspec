# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'liquidoc/version'

Gem::Specification.new do |spec|
  spec.name          = 'liquidoc'
  spec.version       = Liquidoc::VERSION
  spec.authors       = ['railscard']
  spec.email         = ['railscard@gmail.com']
  spec.summary       = %q{Liquid in your docx documents}
  spec.description   = %q{Liquidoc brings liquid template language to your docx documents.}
  spec.homepage      = 'http://github.com/railscard/liquidoc'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'liquid', '>= 4.0.0'
  spec.add_dependency 'nokogiri', '~> 1.8.2'
  spec.add_dependency 'rubyzip', '>= 0.9.5'
  spec.add_dependency 'mimemagic', '~> 0.3.2'

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'minitest', '~> 5.4'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'pry'

  spec.required_ruby_version = Gem::Requirement.new('>= 2.0')
end
