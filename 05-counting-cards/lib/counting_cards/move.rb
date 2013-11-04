module CountingCards
  class Move
    attr_accessor :type, :card, :actor

    # +KD:Rocky
    def initialize(text)
      @type = text[0]
      @card = text[1..2]
      @actor = decode_actor(text)
    end

    def to_s
      "#{type}#{card}:#{actor}"
    end

    private 

    def decode_actor(text)
      tokens = text.split(':')
      if tokens.size == 2
        tokens[1]
      end
    end

  end
end