require_relative "menu_options"
require_relative "background"
require_relative "../levels/level_one"
require_relative "configuration"
require_relative "menu_score"
class MainMenu

OPTIONS_MARGIN_TOP = 200
MARGIN_INTERNAL_Y = 80
OPTIONS = [0,1,2,3]

  def initialize(window)
    @tailsh = Gosu::Image.new('media/images/player/jump_3.png')
    @width = @tailsh.width
    @height  = @tailsh.height
    @taill = Gosu::Image.new('media/images/enemies/lantern/dead_1.png')
    @tailn = Gosu::Image.new('media/images/enemies/ninja/walk_1.png')
    @tailk = Gosu::Image.new('media/images/enemies/knight/jump_2.png')
    @background = Background.new(self.class.name + "")
    @title = Gosu::Image.from_text("Las Aventuras de SuperRuby", Utils::FONT_SIZE_BIG, font: Utils.default_font, )
    @x = Utils.center_x(@title)

    @options = []
    ["Jugar","Puntajes","Configuracion","Salir"].each_with_index do |text, index|
      option_y = OPTIONS_MARGIN_TOP + (index * MARGIN_INTERNAL_Y)
      @options << MenuOption.new(text, option_y)
    end
    @current_option = OPTIONS[0]
  #  @menu_score = MenuScore.new
    #sonido del menu
    @bip = Gosu::Sample.new(Utils.default_menu_sound)
    #musica del menu
    @musicm = Gosu::Song.new(Utils.default_menu_music)
    #@color = Utils::TEXT_COLOR_TITLE
    @Configuration = Configuration.new
  end

  def draw
    @title.draw(@x,0,1,1,1, 0xff_ff0000)
    @options.each do |option|
      is_selected = option == @options[@current_option]
      option.draw(is_selected)
    end
    @background.draw
    @tailsh.draw(@options[2].get_option_x - @tailsh.width ,@options[2].get_option_y ,1)
    @taill.draw(120, Utils.get_height - @taill.height, 1)
    @tailn.draw(Utils.get_width - (@tailn.width * 2), @tailn.height + @title.height, 1, -1)
    @tailk.draw(Utils.get_width - (@tailk.width * 4), (Utils.get_height - @tailk.height) - MARGIN_INTERNAL_Y, 1, -1) 
  end

  def update
    @musicm.play(true) if Utils.get_music_option == 2 && Utils.get_sound_option == 0
  end

  def button_down(id)
    if id == Gosu::KbDown || id == Gosu::KbS
      @current_option = @current_option == OPTIONS[3] ? OPTIONS[0] : OPTIONS[@current_option + 1]
      @bip.play if Utils.get_effect_sounds_option == 4 && Utils.get_sound_option == 0
    elsif id == Gosu::KbUp || id == Gosu::KbW
      @current_option = @current_option == OPTIONS[0] ? OPTIONS[3] : OPTIONS[@current_option - 1]
      @bip.play if Utils.get_effect_sounds_option == 4 && Utils.get_sound_option == 0
    elsif id == Gosu::KbEscape
      @exit = true
    end
    if @current_option == OPTIONS[0] && (id == Gosu::KbSpace || id == Gosu::KbReturn)
      @play = true
    elsif @current_option == OPTIONS[1] && (id == Gosu::KbSpace || id == Gosu::KbReturn)
      @menu_score = true
    elsif @current_option == OPTIONS[2] && (id == Gosu::KbSpace || id == Gosu::KbReturn)
      @config = true
    elsif @current_option == OPTIONS[3] && (id == Gosu::KbSpace || id == Gosu::KbReturn)
      @exit = true
    end
  end

   def exit?
     @exit
   end

   def play?
     @musicm.stop if @play
     @play
   end

   def config?
     @config
   end

   def menu_score?
     @menu_score
   end

end
