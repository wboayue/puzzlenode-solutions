require 'counting_cards/round'
require 'counting_cards/signal'
require 'counting_cards/move'
require 'counting_cards/notebook'

module CountingCards

  def self.solve
    data_file = File.new(File.join(File.dirname(__FILE__), '../data/input.txt'))
    puts data_file    
  end

end