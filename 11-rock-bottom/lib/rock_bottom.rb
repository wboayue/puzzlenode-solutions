require 'rock_bottom/cave'

module RockBottom

  def self.solve
    data_file = File.join(File.dirname(__FILE__), '../spec/data/simple_cave.txt')

    f = File.new data_file
    iter = f.each_line

    units = Integer(iter.next)

    iter.next

    layout  = self.get_cave iter

    cave = Cave.new layout
    cave.pour(units - 1)
    cave.print
    cave.chart
  end

  def self.get_cave(enum)
    lines = []
    while true
      lines.push enum.next.chomp
    end
  rescue StopIteration
    lines
  end
end