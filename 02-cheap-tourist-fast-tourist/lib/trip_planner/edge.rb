class Edge

  attr_reader :from, :to, :depart_at, :arrive_at, :cost
  
  def initialize(from, to, depart_at, arrive_at, cost)
    @from = from
    @to = to
    @arrive_at = arrive_at
    @depart_at = depart_at
    @cost = cost
  end

  def duration_minutes
    (@arrive - @depart) / 60
  end

  def to_s
    result = ""
    result << format_name(from.name)
    result << " " << format_name(to.name)
    result << " " << format_time(depart_at)
    result << " " << format_time(arrive_at)
    result << " " << format_cost(cost)
    result
  end

  private 

  def format_cost(cost)
    '%.2f' % cost
  end

  def format_name(name)
    name.upcase.to_s
  end

  def format_time(time)
    time.strftime('%H:%M')
  end

end