class Circuit

  def initialize(lines)
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