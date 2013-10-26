require 'counting_cards'

describe CountingCards::Round  do
  
  let(:notes) { "Shady +AS +KD:Rocky +??:Lil -KD:discard -??:Lil" }
  let(:round) { CountingCards::Round.new notes }

  describe "#initialize" do
    it "decodes player" do
      expect(round.player).to eq('Shady')
    end

    it "decodes correct number of moves" do
      expect(round.moves.count).to eq(5)
    end

    it "decodes draw from deck" do
      move = round.moves[0]

      expect(move.type).to eq('+')
      expect(move.card).to eq('AS')
      expect(move.actor).to eq(nil)
    end

    it "decodes reception of card from another player" do
      move = round.moves[1]

      expect(move.type).to eq('+')
      expect(move.card).to eq('KD')
      expect(move.actor).to eq('Rocky')
    end

    it "decodes discarding of card" do
      move = round.moves[3]

      expect(move.type).to eq('-')
      expect(move.card).to eq('KD')
      expect(move.actor).to eq('discard')
    end

    it "decodes passing of card to another player" do
      move = round.moves[4]

      expect(move.type).to eq('-')
      expect(move.card).to eq('??')
      expect(move.actor).to eq('Lil')
    end

  end
end