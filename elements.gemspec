$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "elements/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "elements"
  s.version     = Elements::VERSION
  s.authors     = ["Jose Antonio Pio Gil"]
  s.email       = ["josetonyp@latizana.com"]
  s.homepage    = ""
  s.summary     = "API for Content and Attachment"
  s.description = "API for Content and Attachment"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.2.4"
  s.add_dependency 'globalize', '~> 5.0.0'
  s.add_dependency 'redcarpet'
  s.add_dependency 'paper_trail'
  s.add_dependency 'awesome_nested_set'
  s.add_dependency 'carrierwave'
  s.add_dependency 'mini_magick'

  s.add_development_dependency "sqlite3"
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'factory_girl_rails'
end
