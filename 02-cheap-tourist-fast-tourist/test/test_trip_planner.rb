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

end