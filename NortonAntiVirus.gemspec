# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'NortonAntiVirus/version'

Gem::Specification.new do |gem|
  gem.name          = "NortonAntiVirus"
  gem.version       = NortonAntiVirus::VERSION
  gem.authors       = ["Valentin Tsatskin"]
  gem.email         = ["val@valtsatskin.com"]
  gem.description   = %q{Helps protect against the most sofisticated internet organized crime.}
  gem.summary       = %q{Extends your models with filtering for creating, updating, and showing your lovely data.}
  gem.homepage      = "http://github.com/vtsatskin/NortonAntiVirus"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
