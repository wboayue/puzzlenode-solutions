require 'pp'
class TileBag

  def initialize(options)
    fill_bag(options.fetch(:tiles, []))
  end

  def count(tile)
    @counts[tile]
  end

  def points(tile)
    @points[tile]
  end

  def can_form?(word)
    letters = {}
    word.each_char do |letter|
      letters[letter] = letters.fetch(letter, 0) + 1
    end

    result = true
    letters.each do |key, count|
      result = result && @counts[key.to_sym] && @counts[key.to_sym] >= count
    end
    result
  end

  def words_available_in(dictionary)
    dictionary.select {|word| can_form?(word)}
  end

  private 

  def fill_bag(tiles)
    @counts, @points = {}, {}

    tiles.each do |tile|
      letter, points = tile[0...1].to_sym, tile[1..-1].to_i

      @counts[letter] = @counts.fetch(letter, 0) + 1
      @points[letter] = points
    end
  end

end