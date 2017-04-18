Gem::Specification.new do |s|
  s.name        = 'marc21format'
  s.version     = '0.0.1'
  s.date        = '2017-04-18'
  s.summary     = "Provides access to the most recent version of the MARC21 bibliographic format at https://www.loc.gov/marc/bibliographic/ecbdlist.html"
  s.description = "Parses the MARC21 bibliographic format from https://www.loc.gov/marc/bibliographic/ecbdlist.html and provides easy access to the parts of the format description. Simplify the creation and updating of format validation parameters or scripts. Can be used as CLI format reference. Easily extendable."
  s.authors     = ["Maike Kittelmann"]
  s.email       = 'kittelmann@sub.uni-goettingen.de'
  s.files       = Dir['lib/*.rb'] + Dir['lib/marc21format/*.rb'] + Dir['test/*']
  s.homepage    = 'http://rubygems.org/gems/marc21format'
  s.license       = 'MIT'
end