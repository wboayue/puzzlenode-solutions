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

  def to_s
    return "" if @edges.empty?
    departs = @edges.first.depart.strftime('%H:%M')
    arrives = @edges.last.arrive.strftime('%H:%M')

    "#{departs} #{arrives} #{'%.2f' % cost}"
  end

end
