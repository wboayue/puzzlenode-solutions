module RockBottom

  class Cave

    attr_reader :rows, :units_of_water

    def initialize(rows)
      @rows = rows
      @units_of_water = 1
      @current_pos = find_water
    end

    def depth
      @rows.size
    end

    def width
      @rows[0].size
    end

    def [](x, y)
      rows[y][x]
    end

    def []=(x, y, value)
      rows[y][x] = value
    end

    def pour(units)
      units.times do 
        simulate
        @units_of_water += 1
      end
    end

    def print
      puts
      rows.each do |row|
        puts row
      end
    end

    def chart
      text = "#{measure(0)}"
      (1...width).each do |x|
        text += " #{measure(x)} "
      end
      puts text
    end

    def measure(x)
      value = 0
      (0...depth).each do |y|
        value += 1 if self[x, y] == '~'
      end
      value
    end

    private 

    def find_water
      (0..depth).each do |y|
        return [0, y] if self[0, y] == '~' 
      end
      nil
    end

    def simulate
      x, y = @current_pos

      if self[x, y+1] == ' '
        self[x, y+1] = '~'
        @current_pos = [x, y + 1]
      elsif self[x + 1, y] == ' '
        self[x + 1, y] = '~'
        @current_pos = [x + 1, y]
      else
        x = scan(x, y - 1)
        self[x, y -1 ] = '~'
        @current_pos = [x, y -1]        
      end
    end

    def scan(x, y)
      x.downto(0) do |x|
        return x if self[x -1, y] == '~'
      end
    end
  end

end