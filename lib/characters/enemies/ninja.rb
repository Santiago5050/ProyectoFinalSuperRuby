require_relative '../enemies'
require_relative '../../objects/kunai'

class Ninja < Enemies

  def initialize
    super
    @kunai = nil
    @new_kunai
  end

  def self.path
    'media/images/enemies/ninja/'
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
            @kunai = Kunai.new(get_x, get_y, @change, Gosu::milliseconds / 1000)
            @status = :saltar if @jumping
            @move_random = false
            @no_jump = true
        end
      else
        @move_random = false
      end
    end
  end

  def shoot_kunai
    @new_kunai = @no_jump
    @new_kunai ? @kunai : false
  end

end
