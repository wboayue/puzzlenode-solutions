require 'counting_cards/round'
require 'counting_cards/signal'
require 'counting_cards/signal_collection'
require 'counting_cards/move'
require 'counting_cards/notebook'
require 'counting_cards/game'
require 'counting_cards/player'

module CountingCards

  def self.solve
    data_file = File.new(File.join(File.dirname(__FILE__), '../data/sample_input.txt'))
    
    game = Game.new
    game.playback data_file
  end

end

