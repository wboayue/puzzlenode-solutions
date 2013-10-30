require 'counting_cards'

describe CountingCards::Game  do
  
  let(:game) { CountingCards::Game.new }

  it "starts with Shady, Rocky, Danny and Lil" do
    expect(game.players.size).to eq(4)

    expect(game.player_names).to include('Shady')
    expect(game.player_names).to include('Rocky')
    expect(game.player_names).to include('Danny')
    expect(game.player_names).to include('Lil')
  end

  it "starts with empty discard pile" do
    expect(game.discarded).to be_empty
  end

end
