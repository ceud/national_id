# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'national_id/version'

Gem::Specification.new do |spec|
  spec.name          = 'national_id'
  spec.version       = NationalID::VERSION
  spec.authors       = ['Craig Allan']
  spec.email         = ['ceudonym@gmail.com']

  spec.summary       = 'Validator for national ID formats for various countries'
  spec.description   = 'Validator for national ID formats for various countries'
  spec.homepage      = 'https://github.com/ceud/national_id'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  # spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = 'TODO: Set to \'http://mygemserver.com\' to prevent pushes to rubygems.org, or delete to allow pushes to any server.'
  # end

  spec.add_development_dependency 'bundler', '~> 1.8'
  spec.add_development_dependency 'rake', '~> 10.0'

  spec.add_dependency 'railties', '~> 3.1'
end
