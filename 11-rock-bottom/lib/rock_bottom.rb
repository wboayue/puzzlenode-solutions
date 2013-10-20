require 'rock_bottom/cave'

module RockBottom

  def self.solve
    data_file = File.join(File.dirname(__FILE__), '../spec/data/complex_cave.txt')

    f = File.new data_file
    iter = f.each_line

    units = Integer(iter.next)

    iter.next # skip blank line

    cave = Cave.new iter.to_a
    cave.pour(units - 1)
    # cave.print
    cave.chart
  end

end