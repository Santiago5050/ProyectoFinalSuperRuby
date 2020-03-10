require 'gosu'
require 'csv'
require_relative 'background'
class MenuScore
  def initialize
    @title = Gosu::Image.from_text("Mejores Puntuaciones", Utils::FONT_SIZE_BIG, font: Utils.default_font)
    @high_scores = []
    @scores = []
    file_scores = File.read("scores")
    rows = CSV.parse(file_scores)
    rows.each do |row|
      @high_scores << row[0].to_i
    end
    @high_scores.each_with_index do |element, index|
      @scores << Gosu::Image.from_text("##{index + 1}-  #{element}" ,40, font: Utils.default_font)
    end
    @background = Background.new(self.class.name)
  end

  def draw
    @background.draw
    @title.draw(Utils.center_x(@title),1,1,1,1, 0xff_ff0000)
    unless @scores.length == 0
      x = Utils.center_x(@scores[0])
      @scores.each_with_index do |element, index|
        element_y = 150 + (index * 50)
        if index == 0
          element.draw(x, element_y, 1, 1, 1, 0xff_ff0000)
        else
          element.draw(x, element_y, 1, 1, 1, 0xff_00ff00)
        end
      end
    end
  end

  def button_down(id)
    if id == Gosu::KbEscape || id == Gosu::KbSpace
        @screen_status = "Esc"
    end
  end
  def screen_status
    @screen_status
  end
  def update(i)
  end
end
