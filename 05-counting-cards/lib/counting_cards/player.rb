module CountingCards
  class Player
    attr_reader :name, :cards, :game
    attr_accessor :moves

    def initialize(name, game)
      @name, @game, @moves, @cards, = name, game, [], []
    end

    def hand
      cards.join " " 
    end

    def process_moves(moves)
      moves.each { |move| process_move(move) }
    end

    def process_signals(signals)
      signals.each { |signal| process_signal(signal) }
    end

    private

    def process_move(move)
      moves.push move

      if move.type == '+'
        cards.push move.card
      elsif move.type == '-'
        cards.delete move.card

        if move.actor == 'discard'
          game.discard move.card
        end
      end
    end

    def process_signal(signal)
    end

  end
end