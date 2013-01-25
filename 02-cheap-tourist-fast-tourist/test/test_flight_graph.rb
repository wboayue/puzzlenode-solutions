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
      a_paths = @flight_graph.get_node(:a).edges
      b_paths = @flight_graph.get_node(:b).edges

      assert_path_equal({:from => :a, :to => :b, :cost => 100.00, :duration => 60}, a_paths[0])

      assert_path_equal({:from => :b, to: :z, cost: 100.00, duration: 120}, b_paths[0])

      assert_path_equal({:from => :a, to: :z, cost: 300.00, duration: 120}, a_paths[0])
    end
  end

  describe "#load of complex graph" do
    before do
      @flight_graph = FlightGraph.new
      @flight_graph.load(sample_flight_graph_two)
    end

    it "supports multiple paths to between same nodes" do
      node_a = @flight_graph.get_node(:a)

      assert_equal "A B 08:00 09:00 50.00", node_a.edges[0].to_s
      assert_equal "A B 12:00 13:00 300.00", node_a.edges[1].to_s
    end
  end

  describe "given first sample dataset" do
    before do
      @flight_graph = FlightGraph.new sample_flight_graph_one
    end

    it "finds the cheapest route" do
      route = @flight_graph.find_cheapest_route

      assert_equal "09:00 13:30 200.00", route.to_s
    end

    it "finds the fastest route" do
      route = @flight_graph.find_fastest_route

      assert_equal "10:00 12:00 300.00", route.to_s
    end
  end

  describe "given second sample dataset" do
    before do
      @flight_graph = FlightGraph.new sample_flight_graph_two
    end

    it "finds the cheapest route" do
      route = @flight_graph.find_cheapest_route

      puts @flight_graph.nodes.inspect
      puts route.edges.inspect

      assert_equal "08:00 19:00 225.00", route.to_s
    end

    it "finds the fastest route" do
      route = @flight_graph.find_fastest_route

      assert_equal "12:00 16:30 550.00", route.to_s
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
