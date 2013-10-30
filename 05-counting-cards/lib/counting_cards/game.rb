require 'counting_cards/move'

module CountingCards
  class Game
    attr_reader :players

    attr_accessor :signaled, :discarded
    alias :signaled? :signaled

    def initialize
      @players = {
        'Shady' => Player.new('Shady'),
        'Rocky' => Player.new('Rocky'),
        'Danny' => Player.new('Danny'),
        'Lil' => Player.new('Lil')
      }
      @discarded = []
    end

    def player_names
      @players.keys
    end

    def playback(data_file)
      Notebook.new(data_file).each_event do |event|
        event.apply_to(self)
        puts show_hand('Lil') if signaled?
      end       
    end

    def show_hand(player)
      player
    end

  end
end