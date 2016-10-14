# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'money/distributed/fetcher/eu_central_bank/version'

Gem::Specification.new do |spec|
  spec.name          = 'money-distributed-eucb'
  spec.version       = Money::Distributed::Fetcher::EuCentralBank::VERSION
  spec.authors       = ['DarthSim']
  spec.email         = ['darthsim@gmail.com']

  spec.summary       = 'European Central Bank fetcher for money-distributed gem'
  spec.homepage      = 'https://github.com/DarthSim/money-distributed-eucb'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rubocop'

  spec.add_dependency 'money-distributed'
  spec.add_dependency 'nokogiri'
end
