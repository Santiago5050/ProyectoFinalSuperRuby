require 'gosu'

class SelectCharacter

  OPTIONS = [0,1]

  def initialize
    @title = Gosu::Image.from_text("Selecciona tu personaje", Utils::FONT_SIZE_SMALL, font: Utils.default_font)
    @male = Gosu::Image.new('media/images/player/idle_1.png')
    @female = Gosu::Image.new('media/images/player/hero_female/idle_1.png')
    @options = []
    ["Masculino", "Femenino"].each_with_index do |text, index|
      option_y = (Utils.center_y(@title) + 50)
      x = index == 1 ? 1 : -1
      @options << MenuOptionTwo.new(text, option_y, x, 100)
    end
    @current_option = OPTIONS[0]
  end

  def draw
    @title.draw(Utils.center_x(@title), (Utils.center_y(@title) - 50), 1, 1, 1, Utils::TEXT_COLOR)
    @options.each do |element|
      is_selected = element = @options[@current_option]
      element.draw(is_selected)
    end
    @male.draw(Utils.center_x(@male) - 100, ((Utils.get_height - @male.height) - 20), 1)
    @female.draw(Utils.center_x(@female) + 200, ((Utils.get_height - @female.height) - 20), 1, -1, 1)
  end

  def button_down(id)
    case id
      when Gosu::KbLeft, Gosu::KbRight
        @current_option = @current_option == OPTIONS[0] ? OPTIONS[1] : OPTIONS[0]
      when Gosu::KbReturn, Gosu::KbSpace
        if @current_option == 0
          @action = "Male"
        else
          @action = "Female"
        end
    end
  end

  def action
    @action
  end

  def update(id)
  end
end
