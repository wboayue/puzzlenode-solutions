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
    cheapest = nil
    
    each_route do |route|
      cheapest = route if route.cheaper_than?(cheapest)
    end

    cheapest
  end

  def find_fastest_route
    fastest = nil
    
    each_route do |route|
      fastest = route if route.faster_than?(fastest)
    end

    fastest
  end

  def each_route(&block)
    nodes[:a].edges.each do |destination|
      enumerate_routes(destination, block)
    end    
  end

  private

  def enumerate_routes(source, block, visited = [])
    return if visited.include? source

    visited.push(source)

    if source.to.name == :z
      block.call Route.new(visited)
    else 
      source.to.edges.each do |destination|
        next if source.arrive_at > destination.depart_at
        enumerate_routes(destination, block, visited.dup)
      end
    end
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