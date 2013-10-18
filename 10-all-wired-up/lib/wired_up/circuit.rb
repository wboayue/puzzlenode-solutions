require 'wired_up/node'

class Circuit

  attr_reader :lines

  def initialize(lines)
    @lines = lines

    root_pos = Circuit.find_root(lines)
    @root = Node.new(self, x: root_pos[:x], y: root_pos[:y], type: '@')
  end

  def self.find_root(lines)
    {}.tap do |result|
      lines.each_with_index do |line, i|
        if x = line.index('@')
          result[:x] = x
          result[:y] = i
          break
        end
      end
    end  
  end

  def self.load_circuits(data_file)
    f = File.new(data_file)

    circuits, circuit = [], []

    f.each_line do |line|
      line = line.chomp

      if line.empty?
        circuits.push Circuit.new(circuit)
      else
        circuit.push line
      end
    end
    
    circuits.push Circuit.new(circuit) unless circuit.empty?

    circuits
  end

end