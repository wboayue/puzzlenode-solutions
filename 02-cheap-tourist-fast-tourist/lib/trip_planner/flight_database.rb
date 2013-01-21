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

  def find_cheapest
    cheapest = nil

    nodes[:a].paths.each do |to, path|
      path_cost = cost(path)

      if cheapest.nil? || path_cost < cheapest
        cheapest = path_cost
      end
    end

    cheapest
  end

  def cost(path)
    total = path.cost 
    unless path.to == :z
      cheapest = nil
      nodes[path.to].paths.each do |to, path|
        path_cost = cost(path)
        cheapest = path_cost if cheapest.nil? || path_cost < cheapest
      end
      total += cheapest
    end
    total
  end

  private

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