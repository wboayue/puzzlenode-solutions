Gem::Specification.new do |s|
  s.name    = 'international_trade'
  s.version = '0.0.1'
  s.executables = ['international_trade'] 
  s.date = '2013-01-20'
  s.summary     = 'International Trade'
  s.description = 'Solution to puzzle #1 - International trade'

  s.required_ruby_version = '>= 1.9.3'

  s.authors = ['Wil Boayue']
  s.email   = 'wil.boayue@gmail.com'
  s.files = Dir['lib/**/*.rb', 'bin/*', 'LICENSE', '*.md']
  s.license = 'MIT'
  s.homepage = 'https://github.com/wboayue/puzzlenode-solutions'

  s.add_dependency 'nokogiri'
  s.add_dependency 'trollop'
end