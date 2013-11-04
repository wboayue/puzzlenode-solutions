require 'counting_cards/signal_collection'

module CountingCards
  
  class Notebook
    attr_accessor :file_name

    def initialize(file_name)
      @file_name = file_name
    end

    def each_event(&block)
      File.open(file_name) do |file|
        enumerator = file.each_line
        loop do
          line = enumerator.next.chomp
          round = decode_round(line)
          round.signals = decode_signals(enumerator) if has_signals?(enumerator)

          yield round
        end
      end
    end

    private 

    def has_signals?(enumerator)
      line = enumerator.peek
      line && line[0] == '*'
    end

    def decode_round(line)
      Round.new(line)
    end

    def decode_signals(enumerator)
      signals = []
      loop do
        line = enumerator.peek
        return signals if line.nil? || line[0] != '*'
        signals.push Signal.new(enumerator.next.chomp)
      end
    end
  end

end