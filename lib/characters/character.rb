require 'gosu'
require_relative '../modules/utils'

class Character

  attr_accessor :jump_status, :dead, :erase

  def initialize(selected_player = "Male")
    @selected_player = selected_player
    @status = :quieto   #Se guarda el estado actual del personaje
    @change = Utils::SCALE_CHARACTERS  #Se guarda la direccion en la que mira el personaje (+ derecha, - izquierda)
    @images = { quieto: [], muerto: [], correr: [], saltar: [], caminar: []}   #Contiene todas las imagenes del jugador, en cada estado
    @character_velocity = Utils.get_velocity_jump   #Se guarda la velocidad de salto
    @character_velocity2 = Utils.get_velocity_jump   #Se guarda la velocidad de salto
    cargar_srpites    #Se ejecuta el metodo para cargar todas las imagenes
    @x = 20   #Posicion x del personaje
    @y = 0 - @images[:quieto].first.height    #Posicion y del personaje
    @time = 0
    @dead =false
    @color = 0xffffffff
    @gravity = (Utils.get_floor_y / (@images[@status].first.height * Utils::SCALE_CHARACTERS))
    @jumping = false
    @time_kill = 0
    @erase = false
    @second_jump = false
  end

  def dead_status
    @time_dead = Gosu::milliseconds - @time_kill
    if (((@time_dead / 95) % 9) + 1) == 9
      @dead = false
      if (self.class.name + "") == "Player"
        self.ghost = true
        self.ghost_start = Gosu::milliseconds / 1000
        self.ghost_status
      else
        @erase = true
      end
    end
  end

  def kill_character!(time_kill)
    @time_kill = time_kill
    @dead = true
    @status = :muerto
    @time_dead = 0
  end

  def jump?
    @jumping
  end

  def get_y
    @y
  end

  def get_x
    @x
  end

  def get_width
    @images[@status].first.width * Utils::SCALE_CHARACTERS
  end

  def get_height
    @images[@status].first.height * Utils::SCALE_CHARACTERS
  end

  def restart_status  #Restaura el estado del personaje cuando este no se mueve
    @status = :quieto
  end

  def draw(value_gravity)
    value_gravity && !@jumping ? y = Utils.get_floor_y - (@images[@status][((Gosu::milliseconds / 95) % 9) + 1].height * Utils::SCALE_CHARACTERS) : y = @y
    if @change == Utils::SCALE_CHARACTERS
      x = @x
    else
      x = @x + @images[:quieto].first.width * Utils::SCALE_CHARACTERS
    end
    if @jumping   #Si el personaje esta saltando
      jump    #Ejecuta el metodo saltar
      unless @move    #Si el personaje no esta en movimiento, va a dibujar al personaje en funcion del timpo que este lleva en el aire
        @images[@status][((@time / (Utils.get_velocity_jump / 10)) % 9)].draw(x, y, 2, @change, Utils::SCALE_CHARACTERS, @color)
      else    #En caso contrario lo va a dibujar en funcion de los milliseconds
        @images[@status][((Gosu::milliseconds / 95) % 9) + 1].draw(x, y, 2, @change, Utils::SCALE_CHARACTERS, @color)
      end
    elsif @dead
      @images[@status][((@time_dead / 95) % 9) + 1].draw(x, y, 2, @change, Utils::SCALE_CHARACTERS, @color)
    else    #Si el personaje no esta saltando lo dibuja en funcion de los milliseconds
      @y += @gravity unless value_gravity
      @images[@status][((Gosu::milliseconds / 95) % 9) + 1].draw(x, y, 2, @change, Utils::SCALE_CHARACTERS, @color)
    end
  end

  def set_move(move)    #Setea la varieble, dependiendo si el personaje se mueve o no
    @move = move
  end

  def set_time(time)    #Setea el timpo que el personaje lleba en el aire
    @time = time
  end

  def jump    #Contiene el algoritmo que le permite saltar al personaje
      unless @second_jump
       if @character_velocity == ((Utils.get_velocity_jump * -1) + -2)
         @character_velocity = Utils.get_velocity_jump
         @jumping = false
       else
          @jumping = true
          if @character_velocity > 0
            (1..@character_velocity).each do |element|
              @y -= 1
            end
          end
          if @character_velocity < 0
            (1..(@character_velocity * -1)).each do |element|
              @y += 1
            end
          end
          @character_velocity -= Utils::GRAVITY
        end
      else

        if @character_velocity2 == @character_velocity
          @character_velocity2 = Utils.get_velocity_jump
          @second_jump = false
        else
         if @character_velocity2 > 0
           (1..@character_velocity2).each do |element|
             @y -= 1
           end
         end
         if @character_velocity2 < 0
           (1..(@character_velocity2 * -1)).each do |element|
             @y += 1
           end
         end
         @character_velocity2 -= Utils::GRAVITY
        end
      end
  end

  def second_jump(y)
    @second_jump = true
    @second_jump_y = y
  end

  private

  def change(valor)   #Cambia la direccion del personaje dependiendo del valor recibido
    if valor == Utils::SCALE_CHARACTERS * -1
      @change = valor
    else
      @change = valor
    end
  end

  def cargar_srpites    #Carga las imagenes del personaje para cada estado
    if @selected_player == "Male"
      (1..10).each do |element|
        @images[:quieto] << Gosu::Image.new("#{self.class.path}idle_#{element}.png")
      end
      (1..10).each do |element|
        @images[:muerto] << Gosu::Image.new("#{self.class.path}dead_#{element}.png")
      end
      (1..10).each do |element|
        @images[:correr] << Gosu::Image.new("#{self.class.path}run_#{element}.png")
      end
      (1..10).each do |element|
        @images[:saltar] << Gosu::Image.new("#{self.class.path}jump_#{element}.png")
      end

      unless (self.class.name + "") == "Player"
        (1..10).each do |element|
          @images[:caminar] << Gosu::Image.new("#{self.class.path}walk_#{element}.png")
        end
      end
    else
      (1..10).each do |element|
        @images[:quieto] << Gosu::Image.new("#{self.class.path}hero_female/idle_#{element}.png")
      end
      (1..10).each do |element|
        @images[:muerto] << Gosu::Image.new("#{self.class.path}hero_female/dead_#{element}.png")
      end
      (1..10).each do |element|
        @images[:correr] << Gosu::Image.new("#{self.class.path}hero_female/run_#{element}.png")
      end
      (1..10).each do |element|
        @images[:saltar] << Gosu::Image.new("#{self.class.path}hero_female/jump_#{element}.png")
      end
    end
  end
end
