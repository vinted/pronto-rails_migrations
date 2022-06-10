# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pronto/rails_migrations/version'

Gem::Specification.new do |spec|
  spec.name          = "pronto-rails_migrations"
  spec.version       = Pronto::RAILS_MIGRATIONS_VERSION
  spec.authors       = ["Vinted"]
  spec.email         = ["backend@vinted.com"]

  spec.summary       = %q{Validate migration and application code change seperation}
  spec.description   = %q{This pronto runner warns when migrations are run and application code is changed at the same time}
  spec.homepage      = "https://github.com/vinted/pronto-rails_migrations"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency('pronto', '>= 0.10.0')
  spec.add_dependency('faraday', '~> 1.10.0')
  spec.add_dependency('multipart-post', '~> 2.1.1')
  spec.add_dependency('sawyer', '~> 0.8.2')

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 12.0"
end
