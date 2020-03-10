require_relative 'character'

class Player < Character

  attr_accessor :ghost, :ghost_start

  def initialize(selected_player)
    super(selected_player)
    @selected_player = selected_player
    @y = Utils.get_floor_y - (@images[:quieto].first.height * Utils::SCALE_CHARACTERS)
    @ghost = false
  end

  def self.path
    'media/images/player/'
  end

  def set_status(id)
    @status = :saltar if @jumping && !@move
      case id
        when Gosu::KbLeft
          change(Utils::SCALE_CHARACTERS * -1) if @change == Utils::SCALE_CHARACTERS
          @status = :correr
        when Gosu::KbRight
          change(Utils::SCALE_CHARACTERS) if @change == Utils::SCALE_CHARACTERS * -1
          @status = :correr
      end
  end

  def move_left!
    unless @dead
      @x -= 6 if  @x >= 0
    end
  end

  def move_right!
    unless @dead
      @x += 6 if @x <= Utils.get_width - (@images[:correr].first.width * Utils::SCALE_CHARACTERS)
    end
  end

  def ghost_status
    if @ghost == true
      @ghost_current = Gosu::milliseconds / 1000

      if (@ghost_current - @ghost_start) <= 2
        @ghost = true
        @color = 0x33ffffff
      else
        @ghost = false
        @color = 0xffffffff
      end
    end
  end

end
