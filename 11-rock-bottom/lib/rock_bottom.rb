require 'rock_bottom/cave'

module RockBottom

  def self.solve
    data_file = File.new(File.join(File.dirname(__FILE__), '../spec/data/complex_cave.txt'))
    
    enum = data_file.each_line

    units = Integer(enum.next)

    enum.next # skip blank line

    cave = Cave.new enum.to_a

    cave.pour(units - 1)
    cave.chart
  end

end