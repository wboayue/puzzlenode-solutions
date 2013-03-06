require 'turtle_tracks'

describe TurtleTracks  do
  describe "#initialize" do
    it "should create canvas and process lines" do
      input_file = "input.txt"
      tracks = TurtleTracks.new input_file
      tracks.data_file.should === input_file 
    end
  end

  describe "#process" do
    before do
      @input_file = "input.txt"
      @tracks = TurtleTracks.new @input_file
    end

    it "should create canvas and process lines" do
      canvas = double('canvas')
      turtle = double('turtle')
      
      File.should_receive(:open).with(@input_file).and_yield(stubbed_file)
      Canvas.should_receive(:new).with({width: 10, height: 10}).and_return(canvas)
      Turtle.should_receive(:new).with(canvas).and_return(turtle)

      @tracks.should_receive(:process_line).with("RT 135")

      @tracks.process 
    end
  end

  describe "#process_line" do
    before do
      @input_file = "input.txt"
      @tracks = TurtleTracks.new @input_file

      @canvas = @tracks.canvas = double('canvas')
      @turtle = @tracks.turtle = double('turtle')
    end

    it "should process forward" do
      @turtle.should_receive(:move_forward).with(10)

      @tracks.process_line "FD 10"
    end

    it "should process backward" do
      @turtle.should_receive(:move_backward).with(20)

      @tracks.process_line "BK 20"
    end

    it "should process right turn" do
      @turtle.should_receive(:turn_right).with(45)

      @tracks.process_line "RT 45"
    end

    it "should process left turn" do
      @turtle.should_receive(:turn_left).with(90)

      @tracks.process_line "LT 90"
    end

    it "should process repeat" do
      @turtle.should_receive(:turn_right).twice.with(90)
      @turtle.should_receive(:move_forward).twice.with(15)

      @tracks.process_line "REPEAT 2 [ RT 90 FD 15 ]"
    end

  end

  def stubbed_file
    stub = double('file')      
    stub.should_receive(:gets).and_return("10\n")
    stub.should_receive(:gets).and_return("\n")
    stub.should_receive(:each_line).and_yield("RT 135\n")
    stub
  end  
end