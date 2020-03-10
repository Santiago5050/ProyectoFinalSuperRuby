require 'gosu'

module Utils

  GRAVITY = 2 #Aceleracion Gravitatoria del personaje
  SCALE_CHARACTERS = 0.5 #Escala de los personajes
  SCALE_FLOOR = 0.5 #Escala del piso

  @windows_height #Altura de la pantalla
  @windows_width #Ancho de la pantalla
  @floor_y #y del piso
  @velocity_jump = 20 #Velocidad del salto
  @sound_option = 0
  @music_option = 2
  @effect_sounds_option = 4

  def self.set_sound_option(option)
    @sound_option = option
  end

  def self.get_sound_option
    @sound_option
  end

  def self.set_music_option(option)
    @music_option = option
  end

  def self.get_music_option
    @music_option
  end

  def self.set_effect_sounds_option(option)
    @effect_sounds_option = option
  end

  def self.get_effect_sounds_option
    @effect_sounds_option
  end

#Obtiene la velocidad de salto
  def self.set_velocity_jump(v)
    @velocity_jump = v
  end

#Devuelve la velocidad de salto actual
  def self.get_velocity_jump
    @velocity_jump
  end

#Devuelve el nivel actual
  def self.get_level
    @current_level
  end

#Obtiene el nivel actual
  def self.set_level(level)
    @current_level = level
  end

  #Devuelve el tamaño del piso
    def self.get_floor_y
      @floor_y
    end

  #Obtiene el y del piso
    def self.set_floor_y(floor_y)
      @floor_y = floor_y
    end

#Devuleve el ancho de la pantalla
  def self.get_width
    @windows_width
  end

#Devuelve el largo de la pantalla
  def self.get_height
    @windows_height
  end

#Define la resolucion de la pantalla
  def self.set_resolution(width, height)
    @windows_width = width
    @windows_height = height
  end

#Centra cualquier objeto que resiva como parametro
  def self.center_x(object)
    (@windows_width / 2) - (object.width / 2)
  end

#Centra cualquer objeto que resiva en y
  def self.center_y(object)
    (@windows_height / 2) - (object.height / 2)
  end

#Tamaño de los titulos
  FONT_SIZE_BIG = 80

#Tamaño de los sub titulos
  FONT_SIZE_SMALL = 60

#Color del titulo
 TEXT_COLOR_TITLE = Gosu::Color.new(255,0,187,51)


#Color de las opciones
  TEXT_COLOR_LIGHT = Gosu::Color.new(255*0.30,0, 187,51)

#Color de las opciones seleccionadas
  TEXT_COLOR= Gosu::Color.new(255,0,187,51)

#Fuente predefinida
  def self.default_font
    'media/fonts/grinched.ttf'
  end

#sonidos del menu
  def self.default_menu_sound
    'media/sounds/effects/menu_option.ogg'
  end

#musica del menu
  def self.default_menu_music
    'media/sounds/music/menu_music.ogg'
  end

  #Define la imagen ItemPoints
  def self.default_item1
    'media/images/levels/1/items/snowman.png'
  end
end
