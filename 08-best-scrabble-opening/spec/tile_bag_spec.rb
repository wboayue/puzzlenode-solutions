require 'scrabble/tile_bag'

describe TileBag do
  subject do
    TileBag.new tiles: ["a2", "a2", "w5", "s1", "x10"]
  end

  describe "#initialize" do
    it "should set counts" do
      subject.count(:a).should == 2
      subject.count(:w).should == 1
      subject.count(:s).should == 1
      subject.count(:x).should == 1
    end

    it "should set points" do
      subject.points(:a).should == 2
      subject.points(:w).should == 5
      subject.points(:s).should == 1
      subject.points(:x).should == 10
    end
  end

  describe "#can_form?" do
    it "should form word saw" do
      subject.can_form?("saw").should be(true)
    end
    
    it "should form word wax" do
      subject.can_form?("wax").should be(true)
    end

    it "should not form word saws" do
      subject.can_form?("saws").should be(false)
    end
  end

  describe "#words_available_in" do
    it "should find words available in dictionary" do
      dictionary = ["saw", "wax", "saws"]
      subject.words_available_in(dictionary).should == ["saw", "wax"]
    end
  end

end
