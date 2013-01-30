class RobotFactory

  attr_reader :north_bank, :south_bank, :size, :robot_starting_position

  def initialize(layout)
    load_layout(layout)
  end

  def load_layout(layout)
    @north_bank = LaserBank.new(layout: layout[0], :fires_on => {even: true, odd: false})
    @south_bank = LaserBank.new(layout: layout[2], :fires_on => {odd: true, even: false})
    @size = layout[1].size
    @robot_starting_position = layout[1].index('X')
  end

  def damage?(click, position)
    @north_bank.damage?(click, position) || @south_bank.damage?(click, position)
  end

end