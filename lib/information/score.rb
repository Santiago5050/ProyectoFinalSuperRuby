require 'gosu'

class Score
  MARGIN_RIGHT = 250
  MARGIN_TOP =  10

  def initialize(points)
    @points = points
    @text = Gosu::Image.from_text("Puntos: #{@points}", 40, font: Utils.default_font,)
  end

  def draw
    @text = Gosu::Image.from_text("Puntos: #{@points}", 40, font: Utils.default_font,)
    @text.draw(Utils.get_width - MARGIN_RIGHT, MARGIN_TOP, 1, 1, 1, Utils::TEXT_COLOR)

  end

  def set_points(point)
    @points += point
  end

  def get_points
    @points
  end



end
