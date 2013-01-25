require 'trip_planner/path'

class Node
  
  attr_accessor :name, :edges

  def initialize(name, edges = [])
    @name = name
    @edges = edges
  end

  def create_edge(destination, depart, arrive, cost)
    edges.push Path.new(name, destination.name, depart, arrive, cost)
  end

end
