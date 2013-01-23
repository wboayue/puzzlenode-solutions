require_relative 'test_helper'

require 'trip_planner/flight_graph'

describe FlightGraph do

  include TestHelper

  describe "#load" do
    before do
      @flight_graph = FlightGraph.new
      @flight_graph.load(sample_flight_graph_one)
    end

    it "should create nodes for vertexes" do
      refute @flight_graph.get_node(:a).nil?, 'should find node :a'
      assert_equal :a, @flight_graph.get_node(:a).name, 'should have name :a'

      refute @flight_graph.get_node(:b).nil?, 'should find node :b' 
      assert_equal :b, @flight_graph.get_node(:b).name, 'should have name :b'

      refute @flight_graph.get_node(:z).nil?, 'should find node :z' 
      assert_equal :z, @flight_graph.get_node(:z).name, 'should have name :z'

      assert @flight_graph.get_node(:q).nil?, 'should not find node :q'
      assert_equal 3, @flight_graph.nodes.size 
    end

    it "should create paths for edges" do
      a_paths = @flight_graph.get_node(:a).paths
      b_paths = @flight_graph.get_node(:b).paths

      assert_path_equal({:from => :a, :to => :b, :cost => 100.00, :duration => 60}, a_paths[:b])

      assert_path_equal({:from => :b, to: :z, cost: 100.00, duration: 120}, b_paths[:z])

      assert_path_equal({:from => :a, to: :z, cost: 300.00, duration: 120}, a_paths[:z])
    end

  end

  describe "#find_cheapest" do
    before do
      @flight_graph = FlightGraph.new
      @flight_graph.load(sample_flight_graph_one)
    end

    it "finds the cheapest route from :a -> :z" do
      cost, route = @flight_graph.find_cheapest_route

      assert_equal 2, route.size, 'route should have 2 segments'
      assert_equal 200.0, cost, 'route should cost 200'

      assert_path_equal({:from => :a, :to => :b, :cost => 100.00}, route[0])
      assert_path_equal({:from => :b, :to => :z, :cost => 100.00}, route[1])
    end
  end

  describe "#find_fastest" do
    before do
      @flight_graph = FlightGraph.new
      @flight_graph.load(sample_flight_graph_one)
    end

    it "finds the fastest route from :a -> :z" do
      cost, route = @flight_graph.find_fastest_route

      assert_equal 1, route.size, 'route should have 1 segment'
      assert_equal 120, cost, 'route should be 120 minutes long'

      assert_path_equal({:from => :a, :to => :z, :duration => 120}, route[0])
    end
  end

  def assert_path_equal(expected, actual)
    name = "#{expected[:from]} -> #{expected[:to]}"

    refute actual.nil?, "#{name}: path expected"

    assert_equal expected[:from], actual.from, "#{name}: expected path from #{expected[:from]}"
    assert_equal expected[:to], actual.to, "#{name}: expected path to #{expected[:to]}"
    assert_equal expected[:cost], actual.cost, "#{name}: expected cost of #{expected[:cost]}" if expected.has_key? :cost
    assert_equal expected[:duration], actual.duration_minutes, "#{name}: expected duration of #{expected[:duration]}" if expected.has_key? :duration
  end

end
