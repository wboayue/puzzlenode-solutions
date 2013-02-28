class Turtle

  attr_accessor :direction
  attr_reader :x, :y

  MOVEMENT_VECTORS = {
      0 => [ 0, -1],
     45 => [ 1, -1],
     90 => [ 1,  0],
    135 => [ 1,  1],
    180 => [ 0,  1],
    225 => [-1,  1],
    270 => [-1,  0],
    315 => [-1, -1],
    360 => [ 0, -1]
  }

  def initialize(canvas)
    @x, @y = canvas.width / 2, canvas.height / 2
    canvas[x, y] = 'X'
    @direction = 0
    @canvas = canvas
  end

  def turn_left(degrees)
    @direction -= degrees
    @direction += 360 if @direction < 0
  end

  def turn_right(degrees)
    @direction += degrees
    @direction =- 360 if @direction > 360
  end

  def move_forward(distance)
    mx, my = MOVEMENT_VECTORS[direction]

    dx = x + (mx * distance)
    dy = y + (my * distance)

    move_to(dx, dy)
  end

  def move_backward(distance)
    mx, my = MOVEMENT_VECTORS[direction]

    dx = x + (mx * distance * -1)
    dy = y + (my * distance * -1)

    move_to(dx, dy)
  end

  def move_to(dx,dy)
    @canvas.draw_line({x: x, y: y}, {x: dx, y: dy})
    @x, @y = dx, dy    
  end

end