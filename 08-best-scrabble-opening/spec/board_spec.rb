require 'scrabble/board'

describe Board do
  subject do
    board =[
      "1 1 1 1 1 1 1 1 1 1 1 1",
      "1 1 1 2 1 2 1 1 1 1 1 1",
      "1 2 1 1 1 3 1 1 1 1 2 1",
      "2 1 1 1 1 1 1 1 1 2 2 1",
      "1 1 1 2 1 1 1 1 1 1 1 1",
      "1 1 1 1 1 1 2 1 1 1 2 1",
      "1 1 1 1 1 1 1 1 2 1 1 1",
      "1 1 1 1 1 1 1 1 1 1 1 2",
      "1 1 1 1 1 1 1 1 1 1 1 1"
    ]

    Board.new board: board
  end

  describe "#initialize" do
    it "should set rows and columns" do
      subject.rows.should == 9
      subject.columns.should == 12
    end

    it "should set multipliers" do
      subject[0, 0].should == 1
      subject[7, 11].should == 2
      subject[2, 5].should == 3
    end
  end


end
