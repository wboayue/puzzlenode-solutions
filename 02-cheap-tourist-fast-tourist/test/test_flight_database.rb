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
      b_paths = @flight_database.get_node(:b).paths

      assert_path_equal({:from => :a, :to => :b, :cost => 100.00, :duration => 60}, a_paths[:b])

      assert_path_equal({:from => :b, to: :z, cost: 100.00, duration: 120}, b_paths[:z])

      assert_path_equal({:from => :a, to: :z, cost: 300.00, duration: 120}, a_paths[:z])
    end

  end

  describe "#find_cheapest" do
    before do
      @flight_database = FlightDatabase.new
      @flight_database.load(sample_flights)
    end

    it "finds the cheapest flight from :a -> :z" do
      assert_equal 200.0, @flight_database.find_cheapest, 'finds cheapest path from :a -> :z'
    end
  end

  def assert_path_equal(expected, actual)
    name = "#{expected[:from]} -> #{expected[:to]}"

    refute actual.nil?, "#{name}: path expected"

    assert_equal expected[:from], actual.from, "#{name}: expected path from #{expected[:from]}"
    assert_equal expected[:to], actual.to, "#{name}: expected path to #{expected[:to]}"
    assert_equal expected[:cost], actual.cost, "#{name}: expected cost of #{expected[:cost]}"
    assert_equal expected[:duration], actual.duration_minutes, "#{name}: expected duration of #{expected[:duration]}"
  end

end
