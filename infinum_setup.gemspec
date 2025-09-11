# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'infinum_setup/version'

Gem::Specification.new do |spec|
  spec.name          = 'infinum_setup'
  spec.version       = InfinumSetup::VERSION
  spec.authors       = ['Team Rails @ Infinum']
  spec.email         = ['team.rails@infinum.com']

  spec.summary       = 'This script will help you bootstrap your shiny new laptop'
  spec.description   = 'This script will help you bootstrap your shiny new laptop'
  spec.homepage      = 'https://github.com/infinum/infinum_setup'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.required_ruby_version = '>= 2.6.10'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.add_dependency 'commander', '~> 4.6.0'
  spec.add_dependency 'tty-prompt'
  spec.add_dependency 'tty-which', '~> 0.2'
end
