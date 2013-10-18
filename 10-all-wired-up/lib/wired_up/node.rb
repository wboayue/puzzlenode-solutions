class Node

  attr_accessor :circuit, :x, :y

  def initialize(circuit, options)
    @circuit = circuit

    @x = options.fetch(:x)
    @y = options.fetch(:y)
    @type = options.fetch(:type)

    # @left = Node.new(circuit, find_left) if left_node?
    # @right = Node.new(circuit, find_right) if right_node?
    # @direct = Node.new(circuit, find_direct) if direct_node?

    # puts @direct.inspect
  end

end