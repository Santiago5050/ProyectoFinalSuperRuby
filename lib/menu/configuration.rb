require 'gosu'
require_relative 'background'
require_relative 'menu_options'
require_relative 'menu_options2'

class Configuration

  OPTIONS = [0,1,2]
  OPTIONS2 = [0,1,2,3,4,5]

  def initialize
    @title = Gosu::Image.from_text("Configuracion", Utils::FONT_SIZE_BIG, font: Utils.default_font)
    @x = Utils.center_x(@title)
    @options = []
    @sub_options =[]
    ["Sonido", "Musica", "Efectos"].each_with_index do |text, index|
      option_y = 130 + (index * 150)
      ["On", "Off"].each_with_index do |text2, index2|
        option_y2 = option_y + 60
        index2 == 0 ? x = -1 : x = 1
        @sub_options << MenuOptionTwo.new(text2, option_y2, x, 50)
      end
      @options << MenuOption.new(text, option_y)
    end
    @current_option = OPTIONS[0]
    @sub_current_option = Utils.get_sound_option
    @background = Background.new(self.class.name + "")
    @bip = Gosu::Sample.new(Utils.default_menu_sound)
    @musicm = Gosu::Song.new(Utils.default_menu_music)
    @musicm.play if Utils.get_music_option == 2 && Utils.get_sound_option == 0
  end

  def draw
    @title.draw(@x,0,1,1,1,0xff_ff0000)
    @options.each do |option|
      is_selected = option == @options[@current_option]
      option.draw(is_selected)
    end
    @sub_options.each do |option|
      is_selected = option == @sub_options[@sub_current_option]
      option.draw(is_selected)
    end
    @background.draw
  end

  def screen_status
    @screen_status
  end

  def button_down(id)
    case id
      when Gosu::KbEscape
        @screen_status = "Esc"
      when Gosu::KbUp, Gosu::KbW
        @bip.play if Utils.get_effect_sounds_option == 4 && Utils.get_sound_option == 0
        if Utils.get_sound_option == OPTIONS2[0]
          if @current_option == OPTIONS[0]
            @sub_current_option = Utils.get_effect_sounds_option
            @current_option = OPTIONS[2]
          elsif @current_option == OPTIONS[1]
            @sub_current_option = Utils.get_sound_option
            @current_option = OPTIONS[0]
          else
            @sub_current_option = Utils.get_music_option
            @current_option = OPTIONS[1]
          end
        end
      when Gosu::KbDown, Gosu::KbS
        @bip.play if Utils.get_effect_sounds_option == 4 && Utils.get_sound_option == 0
        if Utils.get_sound_option == OPTIONS2[0]
          if @current_option == OPTIONS[0]
            @sub_current_option = Utils.get_music_option
            @current_option = OPTIONS[1]
          elsif @current_option == OPTIONS[1]
            @sub_current_option = Utils.get_effect_sounds_option
            @current_option = OPTIONS[2]
          else
            @sub_current_option = Utils.get_sound_option
            @current_option = OPTIONS[0]
          end
          #@current_option = @current_option == OPTIONS[0] ? OPTIONS[1] : OPTIONS[0]
          #@sub_current_option = @current_option == OPTIONS[0] ? Utils.get_music_option : Utils.get_effect_sounds_option
        end
      when Gosu::KbLeft, Gosu::KbRight, Gosu::KbA, Gosu::KbD
        @bip.play if Utils.get_effect_sounds_option == 4 && Utils.get_sound_option == 0
        if @current_option == OPTIONS[0]
          if Utils.get_sound_option == OPTIONS2[0]
            @sub_current_option = OPTIONS2[1]
            Utils.set_sound_option(1)
          else
            @sub_current_option = OPTIONS2[0]
            Utils.set_sound_option(0)
          end
        end
        if Utils.get_sound_option == OPTIONS2[0]
          if @current_option == OPTIONS[1]
            if Utils.get_music_option == OPTIONS2[2]
              @sub_current_option = OPTIONS2[3]
              Utils.set_music_option(3)
            else
              @sub_current_option = OPTIONS2[2]
              Utils.set_music_option(2)
            end
          elsif @current_option == OPTIONS[2]
            if Utils.get_effect_sounds_option == OPTIONS2[4]
              @sub_current_option = OPTIONS2[5]
              Utils.set_effect_sounds_option(5)
            else
              @sub_current_option = OPTIONS2[4]
              Utils.set_effect_sounds_option(4)
            end
          end
        end
    end
  end

  def update(nill)
    Utils.get_music_option == 2 && Utils.get_sound_option == 0 ? @musicm.play : @musicm.stop
  end
end
