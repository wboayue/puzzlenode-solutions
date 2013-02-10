require 'pp'

class Board

  attr_reader :rows, :columns, :tile_bag

  def initialize(options)
    populate_board(options[:board] || [])
    @tile_bag = options[:tile_bag]
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

  def score(row, column, word, direction = :across)
    direction == :across ? score_across(row, column, word) : score_down(row, column, word)
  end

  def can_form?(word)
    @tile_bag.can_form?(word)
  end

  def show_move(move)
    best_board = []
    @cells.each {|row| best_board.push row.dup}

    if move[:direction] == :across
      (move[:col]...(move[:col] + move[:word].size)).each do |i|
        best_board[move[:row]][i] = move[:word][i-move[:col]]
      end      
    else
      (move[:row]...(move[:row] + move[:word].size)).each do |i|
        best_board[i][move[:col]] = move[:word][i-move[:row]]
      end      
    end

    best_board.collect {|cells| cells.join(" ")}
  end

  private

  def score_across(row, column, word)
    result = 0
    return result if column + word.size > columns
    (column...(column + word.size)).each do |i|
      result += @tile_bag.points(word[i-column].to_sym) * @cells[row][i]
    end
    result
  end

  def score_down(row, column, word)
    result = 0
    return result if row + word.size > rows
    (row...(row + word.size)).each do |i|
      result += @tile_bag.points(word[i-row].to_sym) * @cells[i][column]
    end
    result
  end

  def populate_board(board)
    @cells = []

    board.each do |row|
      @cells.push row.split(/\s/).collect {|cell| cell.to_i}
    end
  end

end