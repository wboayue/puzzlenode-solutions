class Route

  attr_accessor :edges


  def initialize(edges = [])
    @edges = edges
  end

  def size
    @edges.size
  end

  def [](i)
    @edges[i]
  end

  def cost
    @edges.map(&:cost).inject(0, :+)
  end

  def duration
    @edges.last.arrive - @edges.first.depart 
  end

  def cheaper_than(other)
    return true if other.nil?

    if self.cost == other.cost
      self.duration < other.duration
    else
      self.cost < other.cost
    end
  end

  def faster_than(other)
    return true if other.nil?

    if self.duration == other.duration
      self.cost < other.cost
    else
      self.duration < other.duration
    end
  end

  def to_s_detailed
    s = ""
    @edges.each do |e|
      s << e.to_s << " -> "
    end
    s 
  end

  def to_s
    return "" if @edges.empty?
    departs = @edges.first.depart.strftime('%H:%M')
    arrives = @edges.last.arrive.strftime('%H:%M')

    "#{departs} #{arrives} #{'%.2f' % cost}"
  end

end
