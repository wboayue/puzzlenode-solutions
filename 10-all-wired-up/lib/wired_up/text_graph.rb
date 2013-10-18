require 'ostruct'

class TextGraph
  
  attr_reader :lines

  def initialize(lines)
    @lines = lines
  end

  def [](x,y)
    return nil unless in_bounds?(x, y)
    lines[y][x]
  end

  def find_root
    lines.each_with_index do |line, i|
      if x = line.index('@')
        return OpenStruct.new x: x, y: i, type: '@'
      end
    end
  end

  def in_bounds?(x, y)
    (0...lines.length).include?(y) && (0...lines[y].length).include?(x)
  end

  def find_left_node
  end

  def find_right_node
  end

  def find_direct_node
    (x-1).downto(0) do |x|
      return {x: x, y: y, type: circuit.lines[y][x]} if circuit.lines[y][x] != '-'
    end
    {}
  end

  def direct_path?(x, y)
    self[x-1, y] == '-'
  end
  
  def left_path?(x, y)
    self[x, y+1] == '|'
  end

  def right_path?(x, y)
    self[x][y-1] == '|'
  end
end