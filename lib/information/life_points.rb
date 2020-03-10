require_relative 'life_point'
require 'gosu'

class LifePoints

  def initialize(quantity)
    @life_points = []
    @dead = false
    (1..quantity).each_with_index do |element, index|
      element = LifePoint.new(index)
      @life_points << element
    end
  end

  def draw
    @life_points.each do |element|
      element.draw #Objeto puntaje dibujo
    end
  end

  def lost_life!
    if @life_points.length > 1
      @life_points.delete_at(@life_points.index(@life_points.last))
    else
      @dead = true
    end
  end

  def win_life!
    if @life_points.length <= 10
      @life_points << LifePoint.new(@life_points.index(@life_points.last) + 1)
    end
  end

  def lifes
    @life_points.length
  end

  def dead?
    @dead
  end

end
