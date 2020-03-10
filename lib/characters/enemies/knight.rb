require_relative '../enemies'

class Knight < Enemies

  def self.path
    'media/images/enemies/knight/'
  end

  def draw(value_gravity)
    if @change == Utils::SCALE_CHARACTERS
      x = @x
    else
      x = @x + @images[:quieto].first.width * Utils::SCALE_CHARACTERS
    end
    if @jumping   #Si el personaje esta saltando
      jump    #Ejecuta el metodo saltar
      unless @move    #Si el personaje no esta en movimiento, va a dibujar al personaje en funcion del timpo que este lleva en el aire
        @images[@status][((@time / (Utils.get_velocity_jump / 10)) % 9)].draw(x, @y, 2, @change, Utils::SCALE_CHARACTERS, @color)
      else    #En caso contrario lo va a dibujar en funcion de los milliseconds
        @images[@status][((Gosu::milliseconds / 95) % 9) + 1].draw(x, @y, 2, @change, Utils::SCALE_CHARACTERS, @color)
      end
    elsif @dead
      if @change == Utils::SCALE_CHARACTERS
        @images[@status][((@time_dead / 95) % 9) + 1].draw(@x - (@images[:quieto].first.width * Utils::SCALE_CHARACTERS), @y, 2, @change, Utils::SCALE_CHARACTERS, @color)
      else
        @images[@status][((@time_dead / 95) % 9) + 1].draw(x + (@images[:quieto].first.width * Utils::SCALE_CHARACTERS) , @y, 2, @change, Utils::SCALE_CHARACTERS, @color)
      end
    else    #Si el personaje no esta saltando lo dibuja en funcion de los milliseconds
      @y += @gravity unless value_gravity
      @images[@status][((Gosu::milliseconds / 95) % 9) + 1].draw(x, @y, 2, @change, Utils::SCALE_CHARACTERS, @color)
    end
  end
end
