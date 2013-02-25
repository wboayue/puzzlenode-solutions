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
  end
  
  private

  def defaults
    {height: 10, width: 10}
  end

  def initialize_pixels(width, height)
    @pixels = Array.new(height) do
      Array.new(width, '.')
    end
  end

end