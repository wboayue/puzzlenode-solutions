require 'scrabble'

describe Scrabble do
  before do
    @best_opening = [
      "1 1 1 1 1 1 1 1 1 1 1 1",
      "1 1 1 2 1 2 1 1 1 1 1 1",
      "1 2 w h i f f l i n g 1",
      "2 1 1 1 1 1 1 1 1 2 2 1",
      "1 1 1 2 1 1 1 1 1 1 1 1",
      "1 1 1 1 1 1 2 1 1 1 2 1",
      "1 1 1 1 1 1 1 1 2 1 1 1",
      "1 1 1 1 1 1 1 1 1 1 1 2",
      "1 1 1 1 1 1 1 1 1 1 1 1"     
    ]

    @input_file = File.join File.dirname(__FILE__), "data/example_input.json"
    @scrabble = Scrabble.new
  end

  describe "#best_opening" do
    it "should show best opening" do
      @scrabble.best_opening(@input_file).should == @best_opening 
    end
  end
end
