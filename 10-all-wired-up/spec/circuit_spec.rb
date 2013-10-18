require 'wired_up'

describe Circuit do
  describe ".load" do
    let(:circuits) { Circuit.load_circuits File.join(File.dirname(__FILE__), '/data/simple_circuits.txt') }

    it "creates circuit for each circuit in datafile" do
      expect(circuits.size).to eq(3)
    end
  end

  describe "#find_root" do
    let(:circuit) {
      [ 
        "0-------------|",
        "              |",
        "              O-----------@",
        "1-------------|"
      ]
    }

    it "finds root node of circuit" do
      expect(Circuit.find_root(circuit)).to eq({x: 26, y: 2})
    end    
  end

end