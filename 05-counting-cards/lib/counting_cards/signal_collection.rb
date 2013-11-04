require 'delegate'

module CountingCards
  class SignalCollection < SimpleDelegator

    def apply_to(game)
      game.signaled = true
    end

    def player
    end
    
  end
end