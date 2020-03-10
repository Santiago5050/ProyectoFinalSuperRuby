class MenuOption

  def initialize(text, y)
    @image = Gosu::Image.from_text(text,60, font: Utils.default_font)
    @x = Utils.center_x(@image)
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

  def get_option_x
    @x
  end

  def get_option_y
    @y
  end
end
