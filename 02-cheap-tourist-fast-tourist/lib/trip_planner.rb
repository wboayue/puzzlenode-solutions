class TripPlanner

  attr_reader :flights

  def initialize(arguments)
    @flights = arguments[:flights]
  end

  def print_best_routes
    each_database do |database|
      cost, cheapest_route = database.find_cheapest_route
      duration, fastest_route = database.find_fastest_route

      puts format_route(cheapest_route)
      puts format_route(fastest_route)
      puts
    end
  end

  def create_graph
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

  def format_route(route)
  end

end
