require 'trip_planner/edge'

class Node
  
  attr_reader :name, :edges

  def initialize(name, edges = [])
    @name = name
    @edges = edges
  end

  def create_edge(destination, depart_at, arrive_at, cost)
    edges.push Edge.new(self, destination, depart_at, arrive_at, cost)
  end

end
