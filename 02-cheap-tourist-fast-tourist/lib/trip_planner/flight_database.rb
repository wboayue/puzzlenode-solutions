require 'trip_planner/node'

class FlightDatabase
  
  attr_reader :nodes
  
  def initialize
    @nodes = {}
  end

  def load(flights)
    flights.each do |flight|
      from, to, depart, arrive = flight.split(' ')

      from = from.downcase.to_sym
      to = to.downcase.to_sym

      @nodes[from] = Node.new(from)
      @nodes[to] = Node.new(to)
    end
  end

  def get_node(name)
    @nodes[name]
  end

end