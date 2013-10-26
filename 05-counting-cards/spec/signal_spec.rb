require 'counting_cards'

describe CountingCards::Signal  do
  
  let(:notes) { "* +8H:Shady -2H:Danny +JD +2D" }
  let(:signal) { CountingCards::Signal.new notes }

  describe "#initialize" do
    it "decodes correct number of moves" do
      expect(signal.moves.count).to eq(4)
    end

    it "decodes move in correct sequence" do
      moves = signal.moves

      expect(moves[0].card).to eq('8H')
      expect(moves[1].card).to eq('2H')
      expect(moves[2].card).to eq('JD')
      expect(moves[3].card).to eq('2D')
    end
  end
end
