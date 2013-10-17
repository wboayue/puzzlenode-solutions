require 'wired_up'

describe Circuit do
  describe "#load" do

    let(:circuits) { Circuit.load_circuits File.join(File.dirname(__FILE__), '/data/simple_circuits.txt') }

    it "creates circuit for each circuit in datafile" do
      expect(circuits.size).to eq(3)
    end

  end
end