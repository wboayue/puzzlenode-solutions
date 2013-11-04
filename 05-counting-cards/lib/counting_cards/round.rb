require 'counting_cards/move'

module CountingCards
  class Round
    attr_accessor :player, :moves, :signals

    def initialize(text)
      tokens = text.split(' ')
      @player = tokens.shift
      @moves = tokens.map { |text| Move.new text }
    end

    def apply_to(game)
      moves.each do |move|
        game[player].add_move move
      end
    end

  end
end