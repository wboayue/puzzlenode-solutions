require 'counting_cards'

describe CountingCards::Notebook  do

  let(:data_file) { File.join(File.dirname(__FILE__), '../data/sample_input.txt') }
  let(:notebook) { CountingCards::Notebook.new data_file }

  it "reads correct number of notes" do
    notes = []
    
    notebook.each_note do |note|
      notes.push note
    end

    expect(notes.size).to eq(29)

    signals = notes.select { |note| note.class == Array }
    expect(signals.size).to eq(5)

    rounds = notes.select { |note| note.class == CountingCards::Round }
    expect(rounds.size).to eq(24)
  end
end