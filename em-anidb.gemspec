# -*- encoding: utf-8 -*-
require File.expand_path('../lib/em-anidb/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Julien Ammous"]
  gem.email         = ["schmurfy@gmail.com"]
  gem.description   = %q{AniDB wrapper}
  gem.summary       = %q{AniDB wrapper really}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.name          = "em-anidb"
  gem.require_paths = ["lib"]
  gem.version       = EmAnidb::VERSION
  
  gem.add_dependency 'ox',              '~> 1.9.4'
  gem.add_dependency 'rest-core',       '~> 2.0.3'
  gem.add_dependency 'em-http-request', '~> 1.0.0'
  gem.add_dependency 'eventmachine',    '~> 1.0.0'
end
