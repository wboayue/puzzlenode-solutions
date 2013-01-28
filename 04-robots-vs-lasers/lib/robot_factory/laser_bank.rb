class LaserBank
  
  def initialize(arguments)
    arguments = defaults.merge arguments

    @fires_on = arguments[:fires_on] 
    load_layout(arguments[:layout])
  end

  def defaults
    {layout: "", fires_on: {even: false, odd: true}}
  end

  def fires_on(click)
    @fires_on[click]
  end

  def load_layout(layout)
    @lasers = {}
    layout.size.times do |i|
      @lasers[i] = true if layout[i] == '|'      
    end
  end

  def laser_at?(index)
    @lasers[index]
  end

end