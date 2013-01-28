class LaserBank
  
  def initialize(arguments)
    arguments = defaults.merge arguments

    @fires_on = arguments[:fires_on] 
    load_layout(arguments[:layout])
  end

  def defaults
    {layout: "", fires_on: {even: false, odd: true}}
  end

  def fires_on?(click)
    @fires_on[click]
  end

  def fires_on=(options)
    @fires_on = options
  end

  def load_layout(layout)
    @lasers = {}

    layout.size.times do |i|
      @lasers[i] = true if layout[i] == '|'      
    end
  end

  def damage?(click, index)
    if click % 2 == 0
      fires_on?(:even) && laser_at?(index)
    else
      fires_on?(:odd) && laser_at?(index)
    end
  end

  def laser_at?(index)
    @lasers[index]
  end

end