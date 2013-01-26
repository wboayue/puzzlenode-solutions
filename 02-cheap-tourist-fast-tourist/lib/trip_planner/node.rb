require 'trip_planner/edge'

class Node
  
  attr_accessor :name, :edges

  def initialize(name, edges = [])
    @name = name
    @edges = edges
  end

  def create_edge(destination, depart, arrive, cost)
    edges.push Edge.new(self, destination, depart, arrive, cost)
  end

end
