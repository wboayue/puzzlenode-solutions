require 'json'
require 'pp'

data = File.read(File.join(File.dirname(__FILE__), '../test/data/sample_vacation_rentals.json'))
pp JSON.parse(data)