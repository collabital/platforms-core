$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "platforms/core/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "platforms-core"
  spec.version     = Platforms::Core::VERSION
  spec.authors     = ["Benjamin Elias"]
  spec.email       = ["12136262+collabital@users.noreply.github.com"]
  spec.homepage    = "https://www.collabital.com"
  spec.summary     = "Login for various collaboration platforms."
  spec.description = "Login to Office 365 Teams, Yammer."
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.0.2", ">= 6.0.2.1"
  spec.add_dependency "twitter-text", ">= 3.0"
  spec.add_dependency "omniauth", ">= 1.0"

  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'factory_bot_rails'
  spec.add_development_dependency 'hashie'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'sinatra'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'yard-activerecord'
end
