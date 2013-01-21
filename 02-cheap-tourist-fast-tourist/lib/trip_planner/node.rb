class Node
  
  attr_accessor :name, :paths

  def initialize(name, paths = {})
    @name, @paths = name, paths
  end

end
