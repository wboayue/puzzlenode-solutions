require 'wired_up'

module WiredUp

  describe WiredUp::Circuit do
    describe ".load" do
      let(:circuits) { Circuit.load_circuits File.join(File.dirname(__FILE__), '/data/simple_circuits.txt') }

      it "creates circuit for each circuit in datafile" do
        expect(circuits.size).to eq(3)
      end

      it "indicates correct state of circuit" do
        expect(circuits[0].powered?).to eq(true)
        expect(circuits[1].powered?).to eq(false)
        expect(circuits[2].powered?).to eq(true)
      end

    end

  end

end