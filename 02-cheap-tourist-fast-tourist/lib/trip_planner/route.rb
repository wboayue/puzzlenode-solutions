class Route

  attr_accessor :edges

  def initialize(edges = [])
    @edges = edges
  end

  def first_flight
    @edges.first
  end

  def last_flight
    @edges.last
  end

  def size
    @edges.size
  end

  def cost
    @edges.map(&:cost).inject(0, :+)
  end

  def duration
    last_flight.arrive_at - first_flight.depart_at 
  end

  def cheaper_than?(other)
    return true if other.nil?

    if self.cost == other.cost
      self.duration < other.duration
    else
      self.cost < other.cost
    end
  end

  def faster_than?(other)
    return true if other.nil?

    if self.duration == other.duration
      self.cost < other.cost
    else
      self.duration < other.duration
    end
  end

  def to_s
    return "" if edges.empty?
    "#{format_time(first_flight.depart_at)} #{format_time(last_flight.arrive_at)} #{'%.2f' % cost}"
  end

  def format_time(time)
    time.strftime('%H:%M')
  end

end
