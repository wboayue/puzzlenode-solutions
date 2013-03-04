require 'turtle_tracks/canvas'
require 'turtle_tracks/turtle'

class TurtleTracks

  attr_reader :data_file, :canvas

  def initialize(file_name)
    @data_file = file_name
  end

  def process
    File.new(data_file) do |f|
      canvas_size = f.gets.to_i
      @canvas = Canvas.new width: canvas_size, height: canvas_size
      f.gets # skip blank line
      f.each_line do |line|
        process_line line
      end
    end
  end

  def process_line(line)
  end
end