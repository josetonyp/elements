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

  s.add_dependency "rails", "~> 4.2.4"

  s.add_development_dependency "sqlite3"
end
