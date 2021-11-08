# frozen_string_literal: true

#require_relative 'lib/rates/version'
require File.expand_path('lib/rates/version', __dir__)

Gem::Specification.new do |spec|
  spec.name = 'rates'
  spec.version = Rates::VERSION
  spec.homepage = 'https://tenhobi.dev'
  spec.license = 'MIT'
  spec.author = 'Jan Bittner'
  spec.email = 'git@tenhobi.dev'
  spec.required_ruby_version = '>= 3.0.0'

  spec.summary = 'Currency rates converter.'
  spec.description = <<~EOF
    Service that enables conversion of origin currency to target currency using CZK exchange rate.
  EOF

  spec.files = Dir['bin/*', 'lib/**/*', '*rates.gemspec', 'LICENSE*', 'README*']
  spec.executables = Dir['bin/*'].map { |f| File.basename(f) }

  spec.add_runtime_dependency 'csv', '~> 3.2'
  spec.add_runtime_dependency 'date', '~> 3.2'
  spec.add_runtime_dependency 'fileutils', '~> 1.6'
  spec.add_runtime_dependency 'net-http', '~> 0.2.0'
  spec.add_runtime_dependency 'thor', '~> 1.1'

  spec.add_development_dependency 'minitest', '~> 5.14'
  spec.add_development_dependency 'simplecov', '~> 0.21.2'
  spec.add_development_dependency 'yard', '~> 0.9.26'
end
