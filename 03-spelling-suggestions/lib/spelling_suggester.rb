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

  def process_tuples
    results = []
    each_tuple do |word, first_option, second_option|
      results.push(suggest_word(word, first_option, second_option))
    end
    results
  end

  def suggest_word(word, first_option, second_option)
    lcs_first_option = lcs_len(word, first_option)
    lcs_second_option = lcs_len(word, second_option)
    result = lcs_first_option > lcs_second_option ? first_option : second_option
    [word, result] 
  end

  def lcs_len(x, y)
    n = x.length
    m = y.length
    table = {}

    (0..n).each do |i|
      (0..m).each do |j|
        if i == 0 || j == 0
          table[[i,j]] = 0
        elsif x[i-1] == y[j-1]
          table[[i,j]] = table[[i-1, j-1]] + 1
        else
          table[[i,j]] = [table[[i-1, j]], table[[i, j-1]]].max
        end
      end
    end

    table.values.max
  end

 
end