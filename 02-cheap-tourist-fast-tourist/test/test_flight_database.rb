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
      assert_equal :a, @flight_database.get_node(:a).name, 'should have name :a'

      refute @flight_database.get_node(:b).nil?, 'should find node :b' 
      assert_equal :b, @flight_database.get_node(:b).name, 'should have name :b'

      refute @flight_database.get_node(:z).nil?, 'should find node :z' 
      assert_equal :z, @flight_database.get_node(:z).name, 'should have name :z'

      assert @flight_database.get_node(:q).nil?, 'should not find node :q'
      assert_equal 3, @flight_database.nodes.size 
    end

    it "should create paths for edges" do
      a_paths = @flight_database.get_node(:a).paths
      z_paths = @flight_database.get_node(:z).paths

      refute a_paths[:b].nil?, 'should have path from a -> b'
      assert_path_equal({:from => :a, :to => :b, :cost => 100.00, :duration => 60}, a_paths[:b])

      refute a_paths[:z].nil?, 'should have path from a -> z'
      assert_path_equal({:from => :a, to: :z, cost: 300.00, duration: 120}, a_paths[:z])

      refute z_paths[:a].nil?, 'should have path from z -> a'
      assert_path_equal({:from => :z, to: :a, cost: 300.00, duration: 120}, z_paths[:a])
      
      refute z_paths[:b].nil?, 'should have path from z -> b'
      assert_path_equal({:from => :z, to: :b, cost: 100.00, duration: 120}, z_paths[:b])
    end

  end
  
  def assert_path_equal(expected, actual)
    name = "#{expected[:from]} -> #{expected[:to]}"
    assert_equal expected[:from], actual.from, "#{name}: expected path from #{expected[:from]}"
    assert_equal expected[:to], actual.to, "#{name}: expected path to #{expected[:to]}"
    assert_equal expected[:cost], actual.cost, "#{name}: expected cost of #{expected[:cost]}"
    assert_equal expected[:duration], actual.duration_minutes, "#{name}: expected duration of #{expected[:duration]}"
  end

end
