class Canvas

  attr_reader :height, :width

  def initialize(options)
    options = defaults.merge(options)
    @width , @height= options[:width], options[:height]
    initialize_pixels(@width, @height)
  end

  def [](x, y)
    @pixels[y][x]
  end

  def []=(x, y, val)
    @pixels[y][x] = val
  end

  def print
    results = []
    (0...height).each do |row|
      results.push @pixels[row].join " "    
    end
    results 
  end

  def draw_line(from, to)
    if Canvas.distance(:x, from, to) >= Canvas.distance(:y, from, to)
      draw_line_x(from, to)
    else
      draw_line_y(from, to)
    end
  end

  def self.distance(axis, from, to)
    points = [from[axis], to[axis]].sort
    points[1] - points[0]
  end

  private

  def calculate_slope(from, to, height, width)
    (to[height].to_f - from[height]) / (to[width].to_f - from[width])
  end

  def draw_line_x(from, to)
    points = [from, to].sort {|a, b| a[:x] <=> b[:x]}
    slope = calculate_slope(points[0], points[1], :y, :x)
    (points[0][:x]..points[1][:x]).each.with_index do |x, i|
      y = points[0][:y] + (i * slope) 
      self[x, y] = 'X'
    end
  end

  def draw_line_y(from, to)
    points = [from, to].sort {|a, b| a[:y] <=> b[:y]}
    slope = calculate_slope(points[0], points[1], :x, :y)
    (points[0][:y]..points[1][:y]).each.with_index do |y, i|
      x = points[0][:x] + (i * slope)
      self[x.to_i, y.to_i] = 'X'
    end
  end

  def defaults
    {height: 10, width: 10}
  end

  def initialize_pixels(width, height)
    @pixels = Array.new(height) do
      Array.new(width, '.')
    end
  end

end