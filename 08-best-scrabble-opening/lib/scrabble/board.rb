require 'pp'

class Board

  attr_reader :rows, :columns

  def initialize(options)
    populate_board(options[:board] || [])
  end

  def columns
    @cells.empty? ? 0 : @cells[0].size
  end

  def rows
    @cells.size
  end

  def [](row, column)
    @cells[row][column]
  end

  private

  def populate_board(board)
    @cells = []

    board.each do |row|
      @cells.push row.split(/\s/).collect {|cell| cell.to_i}
    end
  end

end