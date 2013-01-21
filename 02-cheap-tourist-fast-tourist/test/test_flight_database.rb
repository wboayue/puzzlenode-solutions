require 'minitest/spec'
require 'minitest/autorun'

require 'trip_planner/flight_database'

describe FlightDatabase do

  def sample_flights
    [
      "A B 09:00 10:00 100.00",
      "B Z 11:30 13:30 100.00",
      "A Z 10:00 12:00 300.00"
    ]
  end

  describe "#load" do
    before do
      @flight_database = FlightDatabase.new
      @flight_database.load(sample_flights)
    end

    it "should create nodes for vertexes" do
      refute @flight_database.get_node(:a).nil?, 'should find node :a' 
      refute @flight_database.get_node(:b).nil?, 'should find node :b' 
      refute @flight_database.get_node(:z).nil?, 'should find node :z' 

      assert @flight_database.get_node(:q).nil?, 'should not find node :q'
      assert_equal 3, @flight_database.nodes.size 
    end

    it "should create paths for edges" do
      a_paths = @flight_database.get_node(:a).paths
      z_paths = @flight_database.get_node(:z).paths

      refute a_paths[:b].nil?, 'should have path from a -> b'
      refute a_paths[:z].nil?, 'should have path from a -> z'

      refute z_paths[:a].nil?, 'should have path from z -> a'
      refute z_paths[:b].nil?, 'should have path from z -> b'
    end

  end

end
