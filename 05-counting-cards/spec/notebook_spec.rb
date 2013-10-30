require 'counting_cards'

describe CountingCards::Notebook  do

  let(:data_file) { File.join(File.dirname(__FILE__), '../data/sample_input.txt') }
  let(:notebook) { CountingCards::Notebook.new data_file }

  it "reads correct number of events" do
    events = []
    
    notebook.each_event do |event|
      events.push event
    end

    expect(events.size).to eq(29)

    signals = events.select { |note| note.class == CountingCards::SignalCollection }
    expect(signals.size).to eq(5)

    rounds = events.select { |note| note.class == CountingCards::Round }
    expect(rounds.size).to eq(24)
  end
end