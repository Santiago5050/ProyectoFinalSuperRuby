require 'gosu'
require_relative 'modules/utils'
require_relative 'menu/main_menu'
require_relative 'levels/level_one'
require_relative 'levels/level_two'
require_relative 'levels/level_three'
require_relative 'menu/configuration'
require_relative 'screens_in_game/game_over'
require_relative 'menu/menu_score'
require_relative 'screens_in_game/pause'
require_relative 'screens_in_game/change_level'
require_relative 'menu/select_character'

class Game < Gosu::Window

  START_LEVEL = 1
  START_LIFES = 3
  START_POINTS = 0

  def initialize
    super(Utils.get_width, Utils.get_height)
    self.caption = "Super Ruby"
    @current_screen = MainMenu.new(self)
    @draw_pause = false
    @selected_player = "Male"
    CSV.open("scores", "a")
  end

  def draw
    if @draw_pause
      @pause.draw
    else
      @current_screen.draw
    end
  end

  def update
    unless @draw_pause
      case @current_screen.class.name
        when "MainMenu"
          @current_screen.update()
          if @current_screen.play?
            #@current_screen = ChangeLevel.new("Start", START_LEVEL, Gosu::milliseconds, START_LIFES, START_POINTS)
            @current_screen = SelectCharacter.new()
          elsif @current_screen.config?
            @current_screen = Configuration.new
          elsif @current_screen.menu_score?
             @current_screen = MenuScore.new
          elsif @current_screen.exit?
            self.close()
          end
        when "SelectCharacter"
          if @current_screen.action == "Male"
            @selected_player = "Male"
            @current_screen = ChangeLevel.new("Start", START_LEVEL, Gosu::milliseconds, START_LIFES, START_POINTS)
          elsif @current_screen.action == "Female"
            @selected_player = "Female"
            @current_screen = ChangeLevel.new("Start", START_LEVEL, Gosu::milliseconds, START_LIFES, START_POINTS)
          end
        when "ChangeLevel"
          @current_screen.update()
          if @current_screen.continue? && @current_screen.status == "Start"
            case @current_screen.level
              when 1
                @current_screen = LevelOne.new(@current_screen.get_lifes, @current_screen.get_points, @selected_player)
              when 2
                @current_screen = LevelTwo.new(@current_screen.get_lifes, @current_screen.get_points, @selected_player)
              when 3
                @current_screen = LevelThree.new(@current_screen.get_lifes, @current_screen.get_points, @selected_player)
            end
          elsif @current_screen.continue? && @current_screen.status == "End"
            unless (@current_screen.level + 1) == 4
              @current_screen = ChangeLevel.new("Start", (@current_screen.level + 1), Gosu::milliseconds, @current_screen.get_lifes, @current_screen.get_points)
            else
              @current_screen = GameOver.new(@current_screen.get_points, "LevelThree", "Win")
            end
          end
        when "GameOver"
          if @current_screen.exit?
            self.close()
          elsif @current_screen.play?
            @current_screen = ChangeLevel.new("Start", START_LEVEL, Gosu::milliseconds, START_LIFES, START_POINTS)
          elsif @current_screen.menu_score?
            @current_screen = MenuScore.new
          else
          @current_screen.update(nil)
          end
        when "MenuScore"
          if @current_screen.screen_status == "Esc"
            @current_screen = MainMenu.new(self)
          end
        when "LevelOne", "LevelTwo", "LevelThree"
          if @current_screen.player_dead?
            @current_screen = GameOver.new(@current_screen.dead_score, @current_screen.class.name, "GameOver")
          elsif @current_screen.screen_status[:win]
            @current_screen = ChangeLevel.new("End", Utils.get_level, Gosu::milliseconds, @current_screen.screen_status[:lifes], @current_screen.dead_score)
          elsif @current_screen.screen_status[:status] == "Esc"
            @draw_pause = true
            @pause = Pause.new(
              @current_screen.class.name,
              @current_screen.screen_status[:score],
              @current_screen.screen_status[:lives],
              @current_screen.screen_status[:items]
            )
          end
        when "Configuration"
          if @current_screen.screen_status == "Esc"
            @current_screen = MainMenu.new(self)
          end
      end

      unless @current_screen.class.name == "MainMenu" || @current_screen.class.name == "ChangeLevel"
        if button_down?(Gosu::KbLeft) || button_down?(Gosu::KbA)
          @current_screen.update(Gosu::KbLeft)
        elsif button_down?(Gosu::KbRight) || button_down?(Gosu::KbD)
          @current_screen.update(Gosu::KbRight)
        else
          @current_screen.update(nil)
        end
      end
    else
      if @pause.action == "Menu"
        @draw_pause = false
        @current_screen = MainMenu.new(self)
      elsif @pause.action == "Continue"
        @current_screen.status = nil
        @draw_pause = false
      end
    end
  end

  def button_down(id)
    unless @draw_pause
      @current_screen.button_down(id) unless @current_screen.class.name == "ChangeLevel"
    else
      @pause.button_down(id)
    end
  end

end
