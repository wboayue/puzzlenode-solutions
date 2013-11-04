require 'counting_cards/move'

module CountingCards
  class Signal
    attr_accessor :moves

    def initialize(text)
      @moves = text[1..-1].split(' ').map { |text| Move.new text }
    end

  end
end