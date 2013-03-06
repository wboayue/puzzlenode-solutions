require 'turtle_tracks/canvas'
require 'turtle_tracks/turtle'

class TurtleTracks

  attr_reader :data_file
  attr_accessor :canvas, :turtle

  def initialize(file_name)
    @data_file = file_name
  end

  def process
    File.open(data_file) do |f|
      setup_canvas f.gets.to_i

      f.gets # skip blank line

      f.each_line do |line|
        process_line line.chomp
      end
    end
  end

  def setup_canvas(canvas_size)
    @canvas = Canvas.new width: canvas_size, height: canvas_size
    @turtle = Turtle.new @canvas
  end

  def process_line(line)
    cmd, *args = line.split(/\s/)
    case cmd
    when "RT"
      @turtle.turn_right args.join("").to_i
    when "LT"
      @turtle.turn_left args.join("").to_i
    when "FD"
      @turtle.move_forward args.join("").to_i
    when "BK"
      @turtle.move_backward args.join("").to_i
    when "REPEAT"
      repeat, *cmds = args
      process_repeat repeat.to_i, cmds[1...-1]
    end
  end

  def print
    @canvas.print
  end

  private 

  def process_repeat(repeat, cmds)
    repeat.times do
      current_set = cmds.dup
      num_cmds = cmds.size / 2
      num_cmds.times do
        process_line current_set.shift(2).join(" ") 
      end
    end
  end

end