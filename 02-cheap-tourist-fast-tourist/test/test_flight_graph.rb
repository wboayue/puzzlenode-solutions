require_relative 'test_helper'

require 'trip_planner/flight_graph'

describe FlightGraph do

  include TestHelper

  describe "#load" do
    before do
      @flight_graph = FlightGraph.new
      @flight_graph.load(sample_simple_flight_graph)
    end

    it "should create nodes" do
      assert_equal 3, @flight_graph.nodes.size 

      refute @flight_graph.get_node(:a).nil?, 'should find node :a'
      assert_equal :a, @flight_graph.get_node(:a).name, 'should have name :a'

      refute @flight_graph.get_node(:b).nil?, 'should find node :b' 
      assert_equal :b, @flight_graph.get_node(:b).name, 'should have name :b'

      refute @flight_graph.get_node(:z).nil?, 'should find node :z' 
      assert_equal :z, @flight_graph.get_node(:z).name, 'should have name :z'

      assert @flight_graph.get_node(:q).nil?, 'should not find node :q'
    end

    it "should create edges for node :a" do
      node = @flight_graph.get_node(:a)

      assert_equal "A B 09:00 10:00 100.00", node.edges[0].to_s
      assert_equal "A Z 10:00 12:00 300.00", node.edges[1].to_s
    end

    it "should create edges for node :b" do
      node = @flight_graph.get_node(:b)

      assert_equal "B Z 11:30 13:30 100.00", node.edges[0].to_s
    end

  end

  describe "#load of complex graph" do
    before do
      @flight_graph = FlightGraph.new
      @flight_graph.load(sample_complex_flight_graph)
    end

    it "supports multiple paths to between same nodes" do
      node_a = @flight_graph.get_node(:a)

      assert_equal "A B 08:00 09:00 50.00", node_a.edges[0].to_s
      assert_equal "A B 12:00 13:00 300.00", node_a.edges[1].to_s
    end
  end

  describe "#each_route" do
    before do
      @flight_graph = FlightGraph.new
      @flight_graph.load(sample_simple_flight_graph)
    end

    it "should enumerate all routes" do
      expected_routes = [
        "09:00 13:30 200.00",
        "10:00 12:00 300.00"
      ]

      actual_routes = []

      @flight_graph.each_route do |route|
        actual_routes.push route.to_s
      end

      assert_equal expected_routes, actual_routes
    end

  end

  describe "given simple sample dataset" do
    before do
      @flight_graph = FlightGraph.new sample_simple_flight_graph
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

  describe "given complex sample dataset" do
    before do
      @flight_graph = FlightGraph.new sample_complex_flight_graph
    end

    it "finds the cheapest route" do
      route = @flight_graph.find_cheapest_route

      assert_equal "08:00 19:00 225.00", route.to_s
    end

    it "finds the fastest route" do
      route = @flight_graph.find_fastest_route

      assert_equal "12:00 16:30 550.00", route.to_s
    end
  end

end
