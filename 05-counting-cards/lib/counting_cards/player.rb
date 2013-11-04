module CountingCards
  class Player
    attr_reader :name
    attr_accessor :moves

    def initialize(name)
      @name, @moves = name, []
    end

    def add_move(move)
      moves.push move
    end

    def hand
      moves.join " " 
    end

  end
end