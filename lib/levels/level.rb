require_relative '../information/life_points'
require_relative '../modules/utils'
require_relative '../characters/player'
require_relative '../characters/enemies/lantern'
require_relative '../objects/floor'
require_relative '../objects/tiles'
require_relative '../information/score'
require_relative '../information/items_points'
require_relative '../objects/items'
require_relative '../objects/tiles'
require_relative '../menu/background'


class Level

    attr_accessor :status

  def initialize(lifes, points, selected_player)
    @floor = Floor.new    #Se crea una instancia del piso
    @player = Player.new(selected_player)   #Se crea una instancia del jugador
    @move = false   #Variable que indica si el jugador esta en movimiento
    @score = Score.new(points)
    @item_points = ItemPoints.new(self.class.name)
    @level_life_points = LifePoints.new(lifes)
  @tiles = Tiles.new(self.class.name)
    @background = Background.new(self.class.name)
    @bip = {
      player_kill: Gosu::Sample.new('media/sounds/effects/player_dead.ogg'),
      item_collected: Gosu::Sample.new('media/sounds/effects/item_collected.ogg'),
      life_collected: Gosu::Sample.new('media/sounds/effects/life_collected.ogg'),
      life_new: Gosu::Sample.new('media/sounds/effects/life_new.ogg'),
      monster_killed: Gosu::Sample.new('media/sounds/effects/monster_killed.ogg')
    }
  end

  def draw
    @level_life_points.draw
    @player.draw(collision?(@player, @floor)[:bot])    #Se dibuja el jugador
    @floor.draw   #Se dibuja el piso
    @score.draw
    @item_points.draw
    @tiles.draw
    @background.draw
  end

  def update(id)
    unless @player.dead
      #Implementacion de movimiento
      if id == Gosu::KbLeft || id == Gosu::KbA
        @player.move_left!
        @player.set_move(true)
      elsif id == Gosu::KbRight || id == Gosu::KbD
        @player.move_right!
        @player.set_move(true)
      elsif @player.jump?
        @player.set_move(false)
      else
        @player.restart_status
        @player.set_move(false)
      end
      #Establecer estado del personaje
      @player.set_status(id)
      #Guarda o resetea en la variable @player.jump_status el timpo que el jugador lleva en el aire
      if @player.jump?
        @player.set_time(@player.jump_status += 1)
      else
        @player.jump_status = 0
      end
      @player.ghost_status
    else
      @player.dead_status
    end
  end

  def button_down(id)
    if (id == Gosu::KbUp || id == Gosu::KbSpace || id == Gosu::KbW) #Al precionar la flecha up o la barra espaciadora se ejecuta el salto
      unless @player.dead
        @player.jump
        @player.set_status(id)
      end
    elsif id == Gosu::KbEscape
      @status = "Esc"
    end
  end

  def screen_status
    {
      status: @status,
      score: @score,
      lives: @level_life_points,
      items: @item_points,
      win: @item_points.level_win?,
      lifes: @level_life_points.lifes
    }
  end

  def player_dead?
    @level_life_points.dead?
  end

  def dead_score
    @score.get_points
  end
  private

  def collision?(player, enemy)
    bottom_collision = enemy.get_y <= player.get_y + player.get_height
    right_collision = enemy.get_x <= player.get_x + player.get_width
    left_collision = enemy.get_x + enemy.get_width >= player.get_x
    top_collision = enemy.get_y + enemy.get_height >= player.get_y
    all = bottom_collision &&  right_collision && left_collision && top_collision
    {all: all, top: top_collision, bot: bottom_collision, right: right_collision, left: left_collision}
  end

  def update_element(element_array, quantity_max, probability, tipo, param, cantidad = 1)  #metodo que controla la creacion de enemigos
    if quantity_max > element_array.length || quantity_max == 0 #si la cantidad que se puede generar de enemigos es mayor a 0
      if Random.rand(0..10000) <= probability #es la probabilidad de que se genere el enemigo
        unless param
          element_array << tipo.new #se agregan los enemigos al arreglo ingresado
        else
          @bip[:life_new].play if param == "Life"
          param == "Life" ? element_array << tipo.new(param) : element_array << tipo.new(param, cantidad)
        end
      end
    end
    element_array #por ultimo se retorna el arreglo con los enemigos dentro
  end

  def enemies_collision(enemy_array, points)
    unless @player.dead || @player.ghost
      if enemy_array.length > 0
        i = 0
        (0..(enemy_array.length - 1)).each do |index|
          unless enemy_array[index - i].dead
            collisions = collision?(@player, enemy_array[index - i])

            if (collisions[:top] && !(collisions[:left] && collisions[:right]))
              enemy_array[index - i].touch_floor = 1 unless enemy_array[index - i].touch_floor == 2
            end

            unless (collisions[:bot])
              enemy_array[index - i].up_head = true
            end

            if collision?(@player, @floor)[:bot]
                enemy_array[index - i].up_head = false
            end

            if ((enemy_array[index - i].touch_floor == 0) && collisions[:top] && (collisions[:left] && collisions[:right]))
              @bip[:player_kill].play if Utils.get_effect_sounds_option == 4 && Utils.get_sound_option == 0
              @level_life_points.lost_life!
              @player.kill_character!(Gosu::milliseconds)
            elsif ((enemy_array[index - i].up_head) && (collisions[:bot] && collisions[:left] && collisions[:right]))
              @player.second_jump(@player.get_y)
              @bip[:monster_killed].play if Utils.get_effect_sounds_option == 4 && Utils.get_sound_option == 0
              enemy_array[index - i].kill_character!(Gosu::milliseconds)
              @score.set_points(points)
              i += 1
            elsif collisions[:all]
              @bip[:player_kill].play if Utils.get_effect_sounds_option == 4 && Utils.get_sound_option == 0
              @level_life_points.lost_life!
              @player.kill_character!(Gosu::milliseconds)
            end
          end
        end
      end
    end
  end

  def items_collision(items_array, points, type, items = 1, array = @item_points)
    unless @player.dead ||  @player.ghost
      if items_array.length > 0
        i = 0
        (0..(items_array.length - 1)).each do |index|
          collisions = collision?(@player, items_array[index - i])

          if collisions[:all]
            items_array.delete_at(index - i)
            @score.set_points(points)
            if type == "Life"
              @bip[:life_collected].play if Utils.get_effect_sounds_option == 4 && Utils.get_sound_option == 0
              @level_life_points.win_life!
            else
              @bip[:item_collected].play if Utils.get_effect_sounds_option == 4 && Utils.get_sound_option == 0
              array.take_item!(items)
            end
            i += 1
          end
        end
      end
    end
  end

  def draw_element(element_array, type = "Element")
    if element_array.length > 0
      i = 0
      (0..(element_array.length - 1)).each do |index|
        collisions = collision?(element_array[index - i], @floor)
        element_array[index - i].draw(collisions[:bot])
        element_array[index - i].touch_floor = 2 if collisions[:bot] && type == "Enemy"
        element_array[index - i].dead_status if type == "Enemy" && element_array[index - i].dead
        if type == "Enemy" && element_array[index - i].erase
          element_array.delete_at(index - i)
          i += 1
        end
      end
    end
  end

  def update_items(items_array)
    items_array.reject! { |item| item.erase?}
  end

  def enemies_move(enemy_array)
    enemy_array.each do |element|
      unless element.dead
        element.random_move!
      end
    end
  end

  def enemies_jump_time(enemy_array)
    if enemy_array.length > 0
      enemy_array.each do |enemy|
        if enemy.jump?
          enemy.set_time(enemy.jump_status += 1)
        else
          enemy.jump_status = 0
        end
      end
    end
  end

end
