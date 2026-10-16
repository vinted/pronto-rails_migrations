lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pronto/rails_migrations/version'

Gem::Specification.new do |spec|
  spec.name          = "pronto-rails_migrations"
  spec.version       = Pronto::RAILS_MIGRATIONS_VERSION
  spec.authors       = ["Vinted"]
  spec.email         = ["backend@vinted.com"]

  spec.summary       = %q{Validate migration and application code change separation}
  spec.description   = %q{This pronto runner warns when migrations are run and application code is changed at the same time}
  spec.homepage      = "https://github.com/vinted/pronto-rails_migrations"
  spec.license       = "MIT"

  spec.metadata["source_code_uri"] = spec.homepage

  spec.files         = Dir["lib/**/*.rb", "LICENSE.txt", "README.md"]
  spec.require_paths = ["lib"]

  spec.add_dependency('pronto', '>= 0.11.1')

  spec.add_development_dependency "base64"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 13.0"
end
