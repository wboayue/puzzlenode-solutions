require 'counting_cards/move'

module CountingCards
  class Round
    attr_accessor :player, :moves, :signals

    def initialize(text)
      tokens = text.split(' ')
      @player = tokens.shift
      @moves = tokens.map { |text| Move.new text }
      @signals = []
    end

    def apply_to(game)
      game[player].process_moves moves
      game[player].process_signals signals
    end

  end
end