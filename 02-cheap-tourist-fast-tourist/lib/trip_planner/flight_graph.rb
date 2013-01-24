require 'trip_planner/node'

require 'bigdecimal'

class FlightGraph
  
  attr_reader :nodes

  def initialize(flights = nil)
    @nodes = {}
    load(flights) unless flights.nil?
  end

  def load(flights)
    flights.each do |flight|
      from, to, depart, arrive, cost = flight.split(' ')
      from, to = from.downcase.to_sym, to.downcase.to_sym

      @nodes[from] ||= Node.new(from)
      @nodes[to] ||= Node.new(to)

      @nodes[from].create_edge(@nodes[to], to_time(depart), to_time(arrive), BigDecimal.new(cost))
    end
  end

  def get_node(name)
    @nodes[name]
  end

  def find_cheapest_route
    find_route :cost
  end

  def find_fastest_route
    find_route :duration_minutes
  end

  private

  def find_route(cost_attribute)
    best_cost, best_route = nil, []

    nodes[:a].paths.each do |to, path|
      route_cost, route = cost(path, cost_attribute)

      if route && route.last.to == :z && (best_cost.nil? || route_cost < best_cost)
        best_cost, best_route = route_cost, route
      end
    end

    [best_cost, best_route]
  end

  def cost(path, cost_attribute, visited = [])
    return nil, nil if visited.include? path.to

    total, route = path.send(cost_attribute), [path]
    visited.push(path.from)

    unless path.to == :z
      cheapest, cheap_route = nil, nil
      nodes[path.to].paths.each do |to, path|
        path_cost, a_route = cost(path, cost_attribute, visited)

        if a_route && (cheapest.nil? || path_cost < cheapest)
          cheapest = path_cost
          cheap_route = a_route
        end 
      end
      total += cheapest unless cheap_route.nil?
      route.concat(cheap_route) unless cheap_route.nil?
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