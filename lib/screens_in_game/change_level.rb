require 'gosu'

class ChangeLevel

  def initialize(status, level, time, lifes, points)
    @initial_time = time / 1000
    @points = points
    @level = level
    @lifes = lifes
    @status = status
    if @status == "Start"
      @title= Gosu::Image.from_text("Level #{@level}", Utils::FONT_SIZE_BIG, font: Utils.default_font)
    else
      @title= Gosu::Image.from_text("Level #{@level} finished!", Utils::FONT_SIZE_BIG, font: Utils.default_font)
      @bip = Gosu::Song.new('media/sounds/effects/life_collected.ogg')
      @bip.play
    end
  end

  def draw
    @title.draw(Utils.center_x(@title), (Utils.center_y(@title) - (@title.height / 2)), 1)
  end

  def update
    unless @status == "End"
      actual_time = Gosu::milliseconds / 1000
      if (actual_time - @initial_time) == 1
        @continue = true
      end
    else
      unless @bip.playing?
        @continue = true
      end
    end
  end

  def get_lifes
    @lifes
  end

  def get_points
    @points
  end

  def level
    @level
  end

  def status
    @status
  end

  def continue?
    @continue
  end
end
