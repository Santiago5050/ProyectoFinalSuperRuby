require 'gosu'

class LifePoint

  def initialize(index)
    @image = Gosu::Image.new('media/images/heart.png')
    @x = 50 + (index * @image.width)
    @y = 5
  end

  def draw
    @image.draw(@x, @y, 1)
  end

end
