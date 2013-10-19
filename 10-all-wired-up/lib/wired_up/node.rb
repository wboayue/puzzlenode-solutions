require 'forwardable'

class Node
  extend Forwardable

  def_delegators :@text_graph_node, :x, :y, :value
  attr_accessor :left, :right, :direct, :text_graph

  def initialize(text_graph, text_graph_node)
    @text_graph = text_graph
    @text_graph_node = text_graph_node

    add_child_nodes
  end

  def powered?
    case value
    when '0'
      false
    when '1'
      true
    when '@'
      direct.powered?
    when 'A' 
      left.powered? & right.powered?
    when 'O'
      left.powered? | right.powered?
    when 'X'
      left.powered? ^ right.powered?
    when 'N'
      not (left || right).powered?
    else
       nil
    end
  end

  private

  def add_child_nodes
    add_left_node if text_graph.left_path?(x, y)
    add_right_node if text_graph.right_path?(x, y)
    add_direct_node if text_graph.direct_path?(x, y)
  end

  def add_left_node
    @left = Node.new(text_graph, text_graph.find_left_node(x, y))
  end

  def add_right_node
    @right = Node.new(text_graph, text_graph.find_right_node(x, y))
  end

  def add_direct_node
    @direct = Node.new(text_graph, text_graph.find_direct_node(x, y))
  end

end