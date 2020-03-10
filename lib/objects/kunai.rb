require 'gosu'

class Kunai

  def initialize(x, y, direction, time)
    @image = Gosu::Image.new("media/images/enemies/ninja/bullet.png")
    @x = x
    @y = y -80
    @direction = direction
    @initial_time = time
  end

  def get_y
    @y
  end

  def get_x
    @x
  end

  def get_width
    @image.width * Utils::SCALE_CHARACTERS
  end

  def get_height
    @image.height * Utils::SCALE_CHARACTERS
  end

  def draw
    @x += 2 * ((@direction + @direction) * -1)
    @y += 1
    @image.draw(@x, @y, 4, @direction, Utils::SCALE_CHARACTERS)
  end

  def erase?
    actual_time = Gosu::milliseconds / 1000
    (actual_time - @initial_time) == 10
  end
end
