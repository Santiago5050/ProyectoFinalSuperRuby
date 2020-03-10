require 'gosu'
require 'csv'
require_relative '../menu/background'
class GameOver < Level

  OPTIONS = [0,1]
  def initialize(points,level, status)
    @bip = Gosu::Sample.new(Utils.default_menu_sound)
    @current_option = OPTIONS[0]
    @high_scores = []
    @points = points
    @status = status
    if @status == "GameOver"
      @text = Gosu::Image.from_text("Game Over", Utils::FONT_SIZE_BIG, font: Utils.default_font)
    else
      @text = Gosu::Image.from_text("You Win", Utils::FONT_SIZE_BIG, font: Utils.default_font)
    end
    @point_show = Gosu::Image.from_text("#{@points} Puntos", Utils::FONT_SIZE_BIG, font: Utils.default_font)
    @text_x = Utils.center_x(@text)
    @text_y = Utils.center_y(@text)
    @points_x = Utils.center_x(@point_show)
    @points_y = Utils.center_y(@point_show)
    @background = Background.new(level)
    save_score
    @options = []
    ["Play Again","Scores"].each_with_index do |text, index|
      option_y = @points_y + 100
      index == 0 ? x = -1 : x = 1
    @options << MenuOptionTwo.new(text, option_y, x, 150)
    end
  end

  def update(id)
  end

   def save_score
     CSV.open("scores", "a") do |row|
       row << ["#{@points}"]
     end
     file_scores = File.read("scores")
     rows = CSV.parse(file_scores)
    rows.each do |row|
      @high_scores << row[0].to_i
    end
      @high_scores = @high_scores.sort! { |x,y| y <=> x }
      @high_scores = @high_scores.take(5)
      File.delete('scores')
      @high_scores.each do |element|
        CSV.open("scores","a") do |row|
          row << ["#{element}"]
        end
      end
   end

  def draw
    @text.draw(@text_x, @text_y - @text.height, 1,1,1, 0xff_00ff00)
    @point_show.draw(@points_x, @points_y + 10, 1,1,1, 0xff_00ff00)
    @background.draw
    @options.each do |option|
      is_selected = option == @options[@current_option]
      option.draw(is_selected)
    end
  end

  def button_down(id)
    if id == Gosu::KbLeft
      @current_option = @current_option == OPTIONS[1] ? OPTIONS[0] : OPTIONS[@current_option + 1]
      @bip.play if Utils.get_effect_sounds_option == 4 && Utils.get_sound_option == 0
    elsif id == Gosu::KbRight
      @current_option = @current_option == OPTIONS[0] ? OPTIONS[1] : OPTIONS[@current_option - 1]
      @bip.play if Utils.get_effect_sounds_option == 4 && Utils.get_sound_option == 0
    end
    if @current_option == OPTIONS[0] && (id == Gosu::KbSpace)
      @play = true
    elsif @current_option == OPTIONS[1] && (id == Gosu::KbSpace)
      @menu_score = true
    end

  end

  def exit?
    @exit
  end

  def play?
    @play
  end

  def menu_score?
    @menu_score
  end

end
