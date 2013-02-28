require 'turtle_tracks/turtle'

describe Turtle do
  describe "#initialize" do
    it "should start at center of canvas" do
      canvas = double('canvas')
      canvas.should_receive(:width).and_return(5)
      canvas.should_receive(:height).and_return(3)
      canvas.should_receive(:[]=).with(2, 1, 'X')

      turtle = Turtle.new canvas

      turtle.x.should == 2
      turtle.y.should == 1
      turtle.direction.should == 0
    end
  end

  describe "#turn_left" do
    before do
      setup_canvas_and_turtle
    end

    it "should turn left" do
      @turtle.turn_left(90)
      @turtle.direction.should == 270
    end
  end

  describe "#turn_right" do
    before do
      setup_canvas_and_turtle
    end

    it "should turn right" do
      @turtle.turn_right(90)
      @turtle.direction.should == 90
    end
  end

  describe "#move_forward" do
    before do
      setup_canvas_and_turtle
    end

    forward_movements = [
      [  0, 4, 0],
      [ 45, 6, 0],
      [ 90, 6, 2],
      [135, 6, 4],
      [180, 4, 4],
      [225, 2, 4],
      [270, 2, 2],
      [315, 2, 0],
      [360, 4, 0]
    ]

    forward_movements.each do |direction, dx, dy|
      it "should move forward at #{direction} degrees" do
        @turtle.direction = direction
        @turtle.x.should == 4
        @turtle.y.should == 2

        @canvas.should_receive(:draw_line).with({x: @turtle.x, y:@turtle.y}, {x:dx, y:dy})

        @turtle.move_forward(2)

        @turtle.x.should == dx
        @turtle.y.should == dy       
      end
    end
  end

  describe "#move_backward" do
    before do
      setup_canvas_and_turtle
    end

    backward_movements = [
      [  0, 4, 4],
      [ 45, 2, 4],
      [ 90, 2, 2],
      [135, 2, 0],
      [180, 4, 0],
      [225, 6, 0],
      [270, 6, 2],
      [315, 6, 4],
      [360, 4, 4]
    ]

    backward_movements.each do |direction, dx, dy|
      it "should move backward at #{direction} degrees" do
        @turtle.direction = direction
        @turtle.x.should == 4
        @turtle.y.should == 2

        @canvas.should_receive(:draw_line).with({x: @turtle.x, y:@turtle.y}, {x:dx, y:dy})

        @turtle.move_backward(2)

        @turtle.x.should == dx
        @turtle.y.should == dy       
      end
    end
  end

  def setup_canvas_and_turtle
    @canvas = double('canvas')

    @canvas.should_receive(:width).and_return(9)
    @canvas.should_receive(:height).and_return(5)
    @canvas.should_receive(:[]=).with(4, 2, 'X')

    @turtle = Turtle.new @canvas
  end

end
