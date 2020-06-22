# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "pronto-rails_migrations"
  spec.version       = '0.10.2'
  spec.authors       = ["Tomas Varneckas"]
  spec.email         = ["t.varneckas@gmail.com"]

  spec.summary       = %q{Validate migration and application code change seperation}
  spec.description   = %q{This pronto runner warns when migrations are run and application code is changed at the same time}
  spec.homepage      = "https://github.com/tomasv/pronto-rails_migrations"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency('pronto', '>= 0.10.0')

  spec.add_development_dependency "bundler", ">= 1.15"
  spec.add_development_dependency "rake", "~> 12.0"
end
