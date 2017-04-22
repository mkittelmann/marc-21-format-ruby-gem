Gem::Specification.new do |s|
  s.name        = 'marc-21-format'
  s.version     = '0.0.1'
  s.date        = '2017-04-18'
  s.summary     = "Provides easy live access to the most recent version of the MARC 21 bibliographic format at https://www.loc.gov/marc/bibliographic/ecbdlist.html"
  s.description = "Parses the MARC 21 bibliographic format from https://www.loc.gov/marc/bibliographic/ecbdlist.html and provides getters. Simplify the creation and updating of format validation parameters or scripts. CLI use possible. Easily extendable."
  s.authors     = ["Maike Kittelmann"]
  s.email       = 'kittelmann@sub.uni-goettingen.de'
  s.files       = Dir['lib/*.rb'] + Dir['lib/marc-21-format/*.rb'] + Dir['test/*']
  s.homepage    = 'http://rubygems.org/gems/marc-21-format'
  s.license       = 'MIT'
end