require 'minitest/spec'
require 'minitest/autorun'

require "mocha/setup"

module TestHelper
  
  def sample_flight_graph_one
    [
      "A B 09:00 10:00 100.00",
      "B Z 11:30 13:30 100.00",
      "A Z 10:00 12:00 300.00"
    ]
  end

  def sample_flight_graph_two
    [
      "A B 08:00 09:00 50.00",
      "A B 12:00 13:00 300.00",
      "A C 14:00 15:30 175.00",
      "B C 10:00 11:00 75.00",
      "B Z 15:00 16:30 250.00",
      "C B 15:45 16:45 50.00",
      "C Z 16:00 19:00 100.00"
    ]
  end

  def sample_flights_data_file
    File.join(File.dirname(__FILE__), 'data/sample-input.txt')    
  end

end
