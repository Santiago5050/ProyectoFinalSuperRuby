require 'gosu'
require_relative '../menu/background'
require_relative '../objects/tiles'
require_relative '../objects/floor'
require_relative '../menu/menu_options2'

class Pause

  OPTIONS = [0,1]

  def initialize(level, score, lives, items)
    @level = level
    @score = score
    @lives = lives
    @items = items
    @background = Background.new(@level)
    @tiles = Tiles.new(@level)
    @floor = Floor.new
    @sub_title= Gosu::Image.from_text("Seguro que deseas abandonar el juego?", Utils::FONT_SIZE_SMALL, font: Utils.default_font)
    @options = []
    ["Si", "No"].each_with_index do |text, index|
      option_y = (Utils.center_y(@sub_title) + 50)
      x = index == 1 ? 1 : -1
      @options << MenuOptionTwo.new(text, option_y, x, 50)
    end
    @current_option = OPTIONS[0]
  end

  def draw
    @background.draw
    @floor.draw
    @tiles.draw
    @score.draw
    @lives.draw
    @items.draw
    @sub_title.draw(Utils.center_x(@sub_title), (Utils.center_y(@sub_title) - 50), 1, 1, 1, Utils::TEXT_COLOR)
    @options.each do |element|
      is_selected = element = @options[@current_option]
      element.draw(is_selected)
    end
  end

  def button_down(id)
    case id
      when Gosu::KbLeft, Gosu::KbRight
        @current_option = @current_option == OPTIONS[0] ? OPTIONS[1] : OPTIONS[0]
      when Gosu::KbReturn, Gosu::KbSpace
        if @current_option == 0
          @action = "Menu"
        else
          @action = "Continue"
        end
    end
  end

  def action
    @action
  end

end
