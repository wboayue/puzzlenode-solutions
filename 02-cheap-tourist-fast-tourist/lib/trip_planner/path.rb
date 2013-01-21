class Path

  attr_reader :from, :to, :cost
  
  def initialize(from, to, cost)
    @from, @to, @cost = from, to, cost
  end

end