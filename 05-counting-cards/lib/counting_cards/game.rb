require 'counting_cards/move'

module CountingCards
  class Game
    attr_reader :players

    attr_accessor :signaled, :discarded
    alias :signaled? :signaled

    def initialize
      @players = {
        'Shady' => Player.new('Shady', self),
        'Rocky' => Player.new('Rocky', self),
        'Danny' => Player.new('Danny', self),
        'Lil' => Player.new('Lil', self)
      }
      @discarded = []
    end

    def player_names
      @players.keys
    end

    def playback(data_file)
      Notebook.new(data_file).each_round do |round|
        round.apply_to(self)
        puts show_hand(round.player) if round.player == 'Lil'
      end       
    end

    def [](player)
      players[player]
    end

    def show_hand(player)
      self[player].hand
    end

    def discard(card)
      discarded.push card
    end

  end
end