class Route

  attr_reader :edges

  def initialize(edges = [])
    @edges = edges
  end

  def first_flight
    edges.first
  end

  def last_flight
    edges.last
  end

  def cost
    edges.map(&:cost).inject(0, :+)
  end

  def duration
    last_flight.arrive_at - first_flight.depart_at 
  end

  def cheaper_than?(other)
    less_than?(other, :cost, :duration)
  end

  def faster_than?(other)
    less_than?(other, :duration, :cost)
  end

  def to_s
    return "" if edges.empty?
    "#{format_time(first_flight.depart_at)} #{format_time(last_flight.arrive_at)} #{'%.2f' % cost}"
  end

  private 

  def less_than?(other, primary_attribute, secondary_attribute)
    return true if other.nil?

    if self.send(primary_attribute) == other.send(primary_attribute)
      self.send(secondary_attribute) < other.send(secondary_attribute)
    else
      self.send(primary_attribute) < other.send(primary_attribute)
    end
  end

  def format_time(time)
    time.strftime('%H:%M')
  end

end
