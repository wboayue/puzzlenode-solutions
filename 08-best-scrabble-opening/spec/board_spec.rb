require 'scrabble/board'

describe Board do
  describe "#initialize" do
    before do
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

      @board = Board.new board: board
    end

    it "should set rows and columns" do
      @board.rows.should == 9
      @board.columns.should == 12
    end

    it "should set multipliers" do
      @board[0, 0].should == 1
      @board[7, 11].should == 2
      @board[2, 5].should == 3
    end
  end

  describe "#score" do
    before do
      board =[
        "1 1 1 1 1",
        "1 1 1 2 1",
        "1 2 1 1 1",
        "2 1 1 1 1",
      ]

      @tile_bag = double('tile_bag')
      @board = Board.new board: board, tile_bag: @tile_bag
    end

    it "should score words" do
      @tile_bag.should_receive(:points).any_number_of_times.with(:s).and_return(3)
      @tile_bag.should_receive(:points).any_number_of_times.with(:a).and_return(4)
      @tile_bag.should_receive(:points).any_number_of_times.with(:w).and_return(5)

      @board.score(0, 0, "saw", :across).should == 12
      @board.score(0, 3, "saw", :down).should == 16
      @board.score(2, 0, "saw", :down).should == 0
    end

  end

end
