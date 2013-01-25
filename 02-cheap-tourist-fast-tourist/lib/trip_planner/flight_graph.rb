require 'bigdecimal'

require 'trip_planner/node'
require 'trip_planner/route'

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
    a, b = find_route(:cost)
    b.nil? ? nil : Route.new(b)
  end

  def find_fastest_route
    a, b = find_route(:duration_minutes)
    b.nil? ? nil : Route.new(b)
  end

  private

  def find_route(cost_attribute)
    best_cost, best_route = nil, []

    nodes[:a].edges.each do |path|
      route_cost, route = cost(path, cost_attribute)

      if route && route.last.to.name == :z && (best_cost.nil? || route_cost < best_cost)
        best_cost = route_cost
        best_route = route
      end
    end

    [best_cost, best_route]
  end

  def cost(source, cost_attribute, visited = [])
    return nil, nil if visited.include? source

    total, route = source.send(cost_attribute), [source]

    visited.push(source)

    unless source.to.name == :z
      cheapest, cheap_route = nil, nil
      source.to.edges.each do |destination|
        next if source.arrive > destination.depart

        path_cost, a_route = cost(destination, cost_attribute, visited)

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