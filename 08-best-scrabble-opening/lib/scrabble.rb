require 'scrabble/board'
require 'scrabble/tile_bag'

require 'json'
require 'pp'

class Scrabble

  def best_opening(input_file)
    puzzle = JSON.parse File.read(input_file)

    dictionary = puzzle['dictionary']
    board = Board.new board: puzzle['board'], tile_bag: TileBag.new(tiles: puzzle['tiles'])

    allowed_words = dictionary.select {|word| board.can_form?(word)}

    best_move = {}

    board.rows.times do |row|
      board.columns.times do |col|
        allowed_words.each do |word|
          score_across = board.score row, col, word, :across
          score_down = board.score row, col, word, :down

          if score_down > score_across
            score, direction = score_down, :down
          else
            score, direction = score_across, :across
          end

          if best_move.empty? || score > best_move[:score]
            best_move[:score] = score
            best_move[:row] = row
            best_move[:col] = col
            best_move[:word] = word
            best_move[:direction] = direction
          end
        end
      end
    end

    board.show_move best_move
  end

end