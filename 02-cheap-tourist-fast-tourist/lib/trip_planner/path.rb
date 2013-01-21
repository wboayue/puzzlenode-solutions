class Path

  attr_reader :from, :to, :cost
  
  def initialize(from, to, depart, arrive, cost)
    @from, @to, @depart, @arrive, @cost = from, to, depart, arrive, cost
  end

  def duration_minutes
    (@arrive - @depart) / 60
  end

  def to_s
    "Path[from=#{from},to=#{to},duration=#{duration_minutes}]"
  end

end