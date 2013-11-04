require 'counting_cards'

describe CountingCards::Notebook  do

  let(:data_file) { File.join(File.dirname(__FILE__), '../data/sample_input.txt') }
  let(:notebook) { CountingCards::Notebook.new data_file }

  it "reads correct number of rounds" do
    rounds = []
    
    notebook.each_round do |round|
      rounds.push round
    end

    expect(rounds.size).to eq(24)
  end
end