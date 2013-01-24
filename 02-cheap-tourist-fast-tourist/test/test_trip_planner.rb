require_relative 'test_helper'

require 'trip_planner'

describe TripPlanner do

  include TestHelper

  describe "#initialize" do
    before do
      @flights = "sample_flights.txt"
      @trip_planner = TripPlanner.new flights: @flights
    end

    it "should assign flights" do
      assert_equal @flights, @trip_planner.flights 
    end
  end

  describe "#each_graph" do
    before do
      @trip_planner = TripPlanner.new flights: sample_flights_data_file
    end

    it "should create graph for each set of edges" do
      graph_one, graph_two = mock('graph_one'), mock('graph_two')

      @trip_planner.expects(:create_graph).with(sample_flight_graph_one).returns(graph_one)
      @trip_planner.expects(:create_graph).with(sample_flight_graph_two).returns(graph_two)

      graphs = []

      @trip_planner.each_graph do |graph|
        graphs.push(graph)
      end

      assert_equal [graph_one, graph_two], graphs, 'loads both graphs' 
    end
  end

  describe "#find_best_routes" do
    before do
      @trip_planner = TripPlanner.new flights: sample_flights_data_file
    end

    it "should collect fastest and cheapest routes for each graph" do
      graph, fast_route, cheap_route = mock('graph'), mock('fast_route'), mock('cheap_route')

      graph.stubs(:find_cheapest_route).returns(cheap_route)
      graph.stubs(:find_fastest_route).returns(fast_route)

      @trip_planner.expects(:each_graph).yields(graph)

      results = @trip_planner.find_best_routes

      assert_equal 1, results.size
      assert_equal cheap_route, results[0].cheapest 
      assert_equal fast_route, results[0].fastest 
    end
  end

end