require 'gosu'

class Items

  def initialize(type, items = 1)
    @items = items
    @type = type
    case @type
      when "Life"
        @item = Gosu::Image.new("media/images/heart.png")
        @scale = 1
      when "LevelOne"
        @item = Gosu::Image.new("media/images/levels/1/items/snowman.png")
        @scale = Utils::SCALE_CHARACTERS
      when "LevelTwo"
        @item = Gosu::Image.new("media/images/levels/2/items/skeleton.png")
        @scale = Utils::SCALE_CHARACTERS
      when "LevelThree"
        if @items == 1
          @item = Gosu::Image.new("media/images/levels/3/items/mushroom_1.png")
          @scale = 0.7
        elsif @items == 2
          @item = Gosu::Image.new("media/images/levels/3/items/mushroom_2.png")
          @scale = 0.7
        end
    end
    @x = Random.rand(0..(Utils.get_width - @item.width))
    @y = 0 - @item.height
    @create_time = Gosu::milliseconds / 1000

    if @type == "Life"
      height = (@item.height * @scale) * 5
      @gravity = ((Utils.get_floor_y) / height)
    else
      height = (@item.height * @scale)
      @gravity = ((Utils.get_floor_y) / height)
    end
  end

  def get_y
    @y
  end

  def get_x
    @x
  end

  def get_width
    @item.width * @scale
  end

  def get_height
    @item.height * @scale
  end

  def draw(value_gravity)
    value_gravity && !@jumping ? @y = Utils.get_floor_y - (@item.height * @scale) : @y = @y
    @y += @gravity unless value_gravity
    @item.draw(@x, @y, 1, @scale, @scale)
  end

  def erase?
    current_time = Gosu::milliseconds / 1000
    (current_time - @create_time) >= 20
  end

end
