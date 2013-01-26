Gem::Specification.new do |s|
  s.name    = 'trip_planner'
  s.version = '0.0.1'
  s.executables = ['trip_planner'] 
  s.date = '2013-01-25'
  s.summary     = 'Trip Planner'
  s.description = 'Solution to puzzle #2 - Cheap tourist, fast tourist'

  s.required_ruby_version = '>= 1.9.3'

  s.authors = ['Wil Boayue']
  s.email   = 'wil.boayue@gmail.com'
  s.files = Dir['lib/**/*.rb', 'bin/*', 'LICENSE', '*.md']
  s.license = 'MIT'
  s.homepage = 'https://github.com/wboayue/puzzlenode-solutions'

  s.add_dependency 'trollop'
end