class TripPlanner

  def initialize(arguments)
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

  def each_database
    database = FlightDatabase.new(flights)
  end

  def format_route(route)
  end

end
