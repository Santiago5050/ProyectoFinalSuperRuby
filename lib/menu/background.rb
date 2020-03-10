require "gosu"
class Background
 def initialize(level)
   #cargar fondo imagen
   @image = []
   (1..3).each do |element|
     @image << Gosu::Image.new("media/images/levels/#{element}/background.png", tileable: true)
   end
   @number = Random.rand(0..2)
   @width = @image[@number].width
   @height  = @image[@number].height
   @level = level
   @scale_x = 1
 end

 def draw
    case @level
    when "LevelOne"
     @image[0].draw(0, 0, 0, 0.7, 0.7)
    when "LevelTwo"
     @image[1].draw(0, 0, 0, 1, 0.7)
    when "LevelThree"
      @image[2].draw(0, 0, 0, 1.3, 0.9)
    when "MainMenu", "Configuration", "MenuScore"
      if @number == 1
        @image[@number].draw(0, 0, 0, 1, 0.7)
      elsif @number == 2
        @image[@number].draw(0, 0, 0, 1.3 ,1)
      else
        @image[@number].draw(0, 0, 0, 0.7, 0.7)
      end
   end
 end

end
