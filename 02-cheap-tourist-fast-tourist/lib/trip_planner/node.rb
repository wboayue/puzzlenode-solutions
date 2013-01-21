require 'trip_planner/path'

class Node
  
  attr_accessor :name, :paths

  def initialize(name, paths = {})
    @name, @paths = name, paths
  end

  def create_edge(destination, depart, arrive, cost)
    paths[destination.name] = Path.new(name, destination.name, depart, arrive, cost)
    # destination.paths[name] = Path.new(destination.name, name, depart, arrive, cost)
  end

end
