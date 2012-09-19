# -*- encoding: utf-8 -*-
require File.expand_path('../lib/indicators/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Nedomas"]
  gem.email         = ["domas.bitvinskas@me.com"]
  gem.description   = %q{A gem for calculating technical analysis indicators.}
  gem.summary       = %q{A gem for calculating technical analysis indicators.}
  gem.homepage      = "http://github.com/Nedomas/indicators"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "indicators"
  gem.require_paths = ["lib"]
  gem.version       = Indicators::VERSION

  gem.add_dependency 'rails'
  gem.add_development_dependency 'securities', ">= 2.0.0", "< 3.0.0"
  gem.add_development_dependency 'rspec'
end
