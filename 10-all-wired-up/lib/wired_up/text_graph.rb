class TextGraph
  
  attr_reader :lines

  TextGraphNode = Struct.new :x, :y, :value

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
        return TextGraphNode.new x, i, '@'
      end
    end
    nil
  end

  def in_bounds?(x, y)
    (0...lines.length).include?(y) && (0...lines[y].length).include?(x)
  end

  def find_left_node(x, y)
    turn = scan_left(x, y)
    scan_down(turn.x, turn.y) unless turn.nil?
  end

  def find_right_node(x, y)
    turn = scan_right(x, y)
    scan_down(turn.x, turn.y) unless turn.nil?
  end

  def find_direct_node(x, y)
    (x-1).downto(0) do |x|
      return TextGraphNode.new x, y, self[x, y] if self[x, y] != '-'
    end
    nil
  end

  def direct_path?(x, y)
    self[x-1, y] == '-'
  end
  
  def left_path?(x, y)
    self[x, y+1] == '|'
  end

  def right_path?(x, y)
    self[x, y-1] == '|'
  end

  private 

  def scan_left(x, y)
    scan_across x, y, 1
  end

  def scan_right(x, y)
    scan_across x, y, -1
  end

  def scan_across(x, y, dir)
    while self[x, y + dir] == '|'
      y += dir
    end
    TextGraphNode.new x, y, self[x, y]
  end

  def scan_down(x, y)
    while self[x - 1, y] == '-'
      x -= 1
    end
    TextGraphNode.new x - 1, y, self[x - 1, y]
  end

end