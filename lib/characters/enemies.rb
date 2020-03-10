require_relative 'character'

class Enemies < Character

  attr_accessor :touch_floor, :up_head

  def initialize
    super
    @x = Random.rand(0..(Utils.get_width - get_width))
    @touch_floor = 0
    @up_head = false
    @move_random = false
    @no_jump = false
  end

  def get_points
    @points
  end

  def random_move!
    if @touch_floor == 2

      unless @move_random
        @initial_time = (Gosu::milliseconds / 1000)
        @move_random = true
        @time_random_move = Random.rand(1..3)
        unless @no_jump
          @movement =  Random.rand(0..5)
        else
          @movement =  Random.rand(0..4)
        end
      end

      @actual_time = (Gosu::milliseconds / 1000)

      if (@actual_time - @initial_time) <= @time_random_move
        case @movement
          when 0
            walk_right
            @no_jump = false
          when 1
            walk_left
            @no_jump = false
          when 2
            run_right
            @no_jump = false
          when 3
            run_left
            @no_jump = false
          when 4
            restart_status
            @no_jump = false
          when 5
            jump
            @status = :saltar if @jumping
            @move_random = false
            @no_jump = true
        end
      else
        @move_random = false
      end
    end
  end

  def walk_right
    change(Utils::SCALE_CHARACTERS) if @change == Utils::SCALE_CHARACTERS * -1
    @status = :caminar unless @jumping
    @x <= Utils.get_width - (@images[:correr].first.width * Utils::SCALE_CHARACTERS) ? @x += 4 : @move_random = false
  end

  def walk_left
    change(Utils::SCALE_CHARACTERS * -1) if @change == Utils::SCALE_CHARACTERS
    @status = :caminar unless @jumping
    @x >= 0 ? @x -= 4 : @move_random = false
  end

  def run_right
    change(Utils::SCALE_CHARACTERS) if @change == Utils::SCALE_CHARACTERS * -1
    @status = :correr unless @jumping
    @x <= Utils.get_width - (@images[:correr].first.width * Utils::SCALE_CHARACTERS) ? @x += 8 : @move_random = false
  end

  def run_left
    change(Utils::SCALE_CHARACTERS * -1) if @change == Utils::SCALE_CHARACTERS
    @status = :correr unless @jumping
    @x >= 0 ? @x -= 8 : @move_random = false
  end
end
