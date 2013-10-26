require 'counting_cards/move'

module CountingCards
  class Round
    attr_accessor :player, :moves

    def initialize(text)
      tokens = text.split(' ')
      @player = tokens.shift
      @moves = tokens.map { |text| Move.new text }
    end

  end
end