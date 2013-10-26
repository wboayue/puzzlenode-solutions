module CountingCards
  
  class Notebook
    attr_accessor :file_name

    def initialize(file_name)
      @file_name = file_name
    end

    def each_note(&block)
      File.open(file_name) do |file|
        signals = []

        file.each_line do |line|
          event = decode_line(line.chomp)
          process_event(event, signals, &block)
        end

        yield signals unless signals.empty?
      end
    end

    private 

    def process_event(event, signals, &block)
      if event.class == Signal
        signals.push event
      else
        unless signals.empty?
          yield signals
          signals.clear
        end
        yield event
      end
    end

    def decode_line(line)
      if line[0] == '*'
        Signal.new(line)
      else
        Round.new(line)
      end
    end
  end

end