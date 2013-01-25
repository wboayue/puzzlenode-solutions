class Path

  attr_reader :from, :to, :depart, :arrive, :cost
  
  def initialize(from, to, depart, arrive, cost)
    @from, @to, @depart, @arrive, @cost = from, to, depart, arrive, cost
  end

  def duration_minutes
    (@arrive - @depart) / 60
  end

  def to_s
    departs = @depart.strftime('%H:%M')
    arrives = @arrive.strftime('%H:%M')

    "#{from.upcase} #{to.upcase} #{departs} #{arrives} #{'%.2f' % cost}"
  end

end