require 'trip_planner/path'

class Node
  
  attr_accessor :name, :edges

  def initialize(name, edges = [])
    @name = name
    @edges = edges
  end

  def create_edge(destination, depart, arrive, cost)
    edges.push Path.new(self, destination, depart, arrive, cost)
  end

  # def each_destination
  #   edges.each
  # end

end
