module RockBottom

  class Cave

    attr_reader :rows
    
    def initialize(rows)
      @rows = rows
    end

    def [](x, y)
      rows[y][x]
    end
  end

end