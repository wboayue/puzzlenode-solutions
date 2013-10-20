require 'wired_up/node'

module WiredUp

  class Circuit

    attr_reader :graph

    def initialize(lines)
      @graph = TextGraph.new(lines)
      @root = Node.new(@graph, @graph.find_root) 
    end

    def powered?
      @root.powered?
    end

    def self.solve(data_file)
      Circuit.load_circuits(data_file).each do |circuit|
        puts circuit.powered? ? "on" : "off"
      end
    end

    def self.load_circuits(data_file)
      f = File.new(data_file)

      circuits, circuit = [], []

      f.each_line do |line|
        line = line.chomp

        if line.empty?
          circuits.push Circuit.new(circuit)
          circuit = []
        else
          circuit.push line
        end
      end
      
      circuits.push Circuit.new(circuit) unless circuit.empty?

      circuits
    end

  end

end