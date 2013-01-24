require 'ostruct'

require 'trip_planner/flight_graph'

class TripPlanner

  attr_reader :flights

  def initialize(arguments)
    @flights = arguments[:flights]
  end

  def find_best_routes
    results = []

    each_graph do |graph|
      cheapest_route = graph.find_cheapest_route
      fastest_route = graph.find_fastest_route

      results.push OpenStruct.new(cheapest: cheapest_route, fastest: fastest_route)
    end

    results
  end

  def create_graph(edges)
    FlightGraph.new(edges)
  end

  def each_graph
    data = File.new(flights)

    number_of_graphs = data.gets.chomp.to_i

    number_of_graphs.times do
      data.gets
      number_of_edges = data.gets.chomp.to_i

      edges = []
      number_of_edges.times do
        edges.push(data.gets.chomp)
      end

      yield create_graph(edges)
    end
  end

end
