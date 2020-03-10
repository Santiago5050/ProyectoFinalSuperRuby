class MenuOptionTwo

  def initialize(text, y, x, distance)
    @image = Gosu::Image.from_text(text,60, font: Utils.default_font)
    @x = Utils.center_x(@image) + (distance * x)
    @y = y
  end

  def draw(selected)
    color = if selected
        Utils::TEXT_COLOR
      else
        Utils::TEXT_COLOR_LIGHT
      end
    @image.draw(@x, @y, 1, 1, 1, color)
  end

end
