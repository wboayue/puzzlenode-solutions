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
      
      File.should_receive(:new).with(@input_file).and_yield(stubbed_file)
      Canvas.should_receive(:new).with({width: 10, height: 10}).and_return(canvas)

      @tracks.should_receive(:process_line).with("RT 135\n")

      @tracks.process 
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