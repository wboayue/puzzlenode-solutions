class SpellingSuggester

  def initialize(input_file)
    @input_file = input_file
  end

  def each_tuple
    File.open(@input_file) do |data|
      num_tuples = data.gets.to_i

      num_tuples.times do
        data.gets
        yield [data.gets.chomp, data.gets.chomp, data.gets.chomp]
      end
    end
  end

  def lcs(x, y)
    return "" if x.empty? || y.empty?

    xx = x[0...-1]
    yy = y[0...-1]

    if x[-1] == y[-1]
      lcs(xx, yy) + x[-1]
    else
      left = lcs(xx, y)
      right = lcs(x, yy)
      left.length > right.length ? left : right
    end
  end

end