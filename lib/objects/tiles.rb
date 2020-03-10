require 'gosu'

class Tiles

  def initialize(level)
    @y = Utils.get_floor_y
    @level = level
    case @level
      when "LevelOne"
         path = "media/images/levels/1/tiles/"
         @igloo = Gosu::Image.new(path + "igloo.png")
         @tree1 = Gosu::Image.new(path + "tree_1.png")
         @tree2 = Gosu::Image.new(path + "tree_2.png")
         @box = Gosu::Image.new(path + "ice_box.png")
         @sing1 = Gosu::Image.new(path + "sign_1.png")
         @sing2 = Gosu::Image.new(path + "sign_2.png")
         @stone = Gosu::Image.new(path + "stone.png")
      when "LevelTwo"
        path = "media/images/levels/2/tiles/"
        @crate = Gosu::Image.new(path + "crate.png")
        @bush1 = Gosu::Image.new(path + "bush_1.png")
        @bush2 = Gosu::Image.new(path + "bush_2.png")
        @box = Gosu::Image.new(path + "grass_1.png")
        @sing1 = Gosu::Image.new(path + "sign_1.png")
        @sing2 = Gosu::Image.new(path + "sign_2.png")
        @stone = Gosu::Image.new(path + "stone.png")
        @tree1 = Gosu::Image.new(path + "tree.png")
        @cactus1 = Gosu::Image.new(path + "cactus_1.png")
        @cactus2 = Gosu::Image.new(path + "cactus_2.png")
      when "LevelThree"
        path = "media/images/levels/3/tiles/"
        @crate = Gosu::Image.new(path + "crate.png")
        @tree1 = Gosu::Image.new(path + "tree_1.png")
        @tree2 = Gosu::Image.new(path + "tree_2.png")
        @tree3 = Gosu::Image.new(path + "tree_3.png")
        @sing1 = Gosu::Image.new(path + "sign_1.png")
        @sing2 = Gosu::Image.new(path + "sign_2.png")
        @stone = Gosu::Image.new(path + "stone.png")
        @bush1 = Gosu::Image.new(path + "bush_1.png")
        @bush2 = Gosu::Image.new(path + "bush_2.png")
      end
  end

  def path
    "media/images/level/1/tiles/"
  end

  def draw
    case @level
      when "LevelOne"
        @igloo.draw(Utils.get_width - @igloo.width, @y - @igloo.height, 1)
        @tree1.draw(110, @y - @tree1.height, 1)
        @tree2.draw(40, @y - @tree2.height, 1)
        @sing1.draw(Utils.get_width - @sing1.width, @y - @sing1.height, 1)
        @sing2.draw(0, @y - @sing2.height, 1)
        @stone.draw(Utils.get_width/2, @y - @stone.height, 1)
      when "LevelTwo"
        @crate.draw(Utils.get_width - @crate.width, @y - @crate.height , 1)
        @bush1.draw(110, @y - @bush1.height, 1)
        @bush2.draw(40, @y - @bush2.height, 1)
        @box.draw(Utils.get_width - @box.width, @y - @box.height, 1)
        @sing1.draw(0, @y - @sing1.height, 1)
        @sing2.draw(200, @y - @sing2.height, 1)
        @stone.draw(Utils.get_width/2, @y - @stone.height, 1)
      when "LevelThree"
        @tree3.draw(Utils.get_width - @tree3.width, @y - @tree3.height , 1)
        @crate.draw(10, @y - (@crate.height/2), 1, 0.5, 0.5)
        @bush1.draw(200, @y - @bush1.height, 1)
        @bush2.draw(350, @y - @bush2.height, 1)
        @sing1.draw(Utils.get_width - @sing1.width, @y - @sing1.height, 1)
        @sing2.draw(@sing2.width, @y - @sing2.height , 1)
        @stone.draw(Utils.get_width/2, @y - @stone.height, 1)
        @tree1.draw(@tree1.width, @y - @tree1.height, 1)
        @tree2.draw(@tree2.width * 2, @y - @tree2.height, 1)
    end
  end

end
