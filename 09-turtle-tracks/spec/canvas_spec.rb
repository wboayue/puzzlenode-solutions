require 'turtle_tracks/canvas'

describe Canvas do

  describe "#initialize" do
    before do
      @canvas = Canvas.new height: 10, width: 15
    end

    it "should have height of 10" do
      @canvas.height.should == 10
    end

    it "should have width of 15" do
      @canvas.width.should == 15
    end

    it "should initialize all pixels to '.'" do
      (0...15).each do |x|
        (0...10).each do |y|
          @canvas[x, y].should == '.'
        end
      end
    end
  end

  describe "#print" do
    before do
      @canvas = Canvas.new height: 3, width: 5
    end

    it "should print empty canvas" do
      expected_canvas = [
        ". . . . .",
        ". . . . .",
        ". . . . ."
      ]

      @canvas.print.should == expected_canvas
    end

    it "should print starting canvas" do
      expected_canvas = [
        ". . . . .",
        ". . X . .",
        ". . . . ."
      ]

      @canvas[2, 1] = 'X'
      @canvas.print.should == expected_canvas
    end
  end

  describe "#draw_line" do
    before do
      @canvas = Canvas.new height: 3, width: 5
    end

    it "should draw a line" do
      expected_canvas = [
        ". . . X .",
        ". . X . .",
        ". X . . ."
      ]

      @canvas.draw_line({x: 1, y: 2}, {x: 3, y: 0})
      @canvas.print.should == expected_canvas
    end

    it "should draw a line" do
      expected_canvas = [
        ". . . X .",
        ". . . X .",
        ". . . X ."
      ]

      @canvas.draw_line({x: 3, y: 0}, {x: 3, y: 2})
      @canvas.print.should == expected_canvas
    end

    it "should draw a line" do
      expected_canvas = [
        ". . . . .",
        ". . X X .",
        ". . . . ."
      ]

      @canvas.draw_line({x: 2, y: 1}, {x: 3, y: 1})
      @canvas.print.should == expected_canvas
    end
  end

  describe "#distance" do
    it "should compute vertical distance" do
      Canvas.distance(:y, {y: 1}, {y: 5}).should == 4
      Canvas.distance(:y, {y: 5}, {y: 1}).should == 4
    end

    it "should compute horizontal distance" do
      Canvas.distance(:x, {x: -1}, {x: 3}).should == 4
      Canvas.distance(:x, {x: -2}, {x: -6}).should == 4
    end
  end

end

