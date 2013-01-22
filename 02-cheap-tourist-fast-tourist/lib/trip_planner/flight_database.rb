require 'trip_planner/node'

require 'bigdecimal'

class FlightDatabase
  
  attr_reader :nodes

  def initialize
    @nodes = {}
  end

  def load(flights)
    flights.each do |flight|
      from, to, depart, arrive, cost = flight.split(' ')
      from , to = from.downcase.to_sym, to.downcase.to_sym

      @nodes[from] ||= Node.new(from)
      @nodes[to] ||= Node.new(to)

      @nodes[from].create_edge(@nodes[to], to_time(depart), to_time(arrive), BigDecimal.new(cost))
    end
  end

  def get_node(name)
    @nodes[name]
  end

  def find_cheapest_route
    best_cost, best_route = nil, nil

    nodes[:a].paths.each do |to, path|
      route_cost, route = cost(path, :cost)

      if best_cost.nil? || route_cost < best_cost
        best_cost, best_route = route_cost, route
      end
    end

    [best_cost, best_route]
  end

  def find_fastest_route
    best_cost, best_route = nil, nil

    nodes[:a].paths.each do |to, path|
      route_cost, route = cost(path, :duration_minutes)

      if best_cost.nil? || route_cost < best_cost
        best_cost, best_route = route_cost, route
      end
    end

    [best_cost, best_route]
  end

  private

  def cost(path, cost_attribute)
    total, route = path.send(cost_attribute), [path]

    unless path.to == :z
      cheapest, cheap_route = nil, nil
      nodes[path.to].paths.each do |to, path|
        path_cost, a_route = cost(path, cost_attribute)

        if cheapest.nil? || path_cost < cheapest
          cheapest = path_cost
          cheap_route = a_route
        end 
      end
      total += cheapest
      route.concat(cheap_route)
    end

    [total, route]
  end

  def to_time(value)
    hour, min = value.split(':')
    time_a = base_time.dup
    
    time_a[3] = hour.to_i
    time_a[4] = min.to_i
    time_a[5] = 0

    Time.gm(*time_a)
  end

  def base_time
    @base_time ||= Time.new.to_a[0..5].reverse
  end

end