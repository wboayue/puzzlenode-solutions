class SpellingSuggester

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