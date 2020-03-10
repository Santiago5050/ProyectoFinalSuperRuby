class Floor

  def initialize
    @floor = []
    @x = 0
    bloque = Gosu::Image.new("media/images/levels/#{Utils.get_level}/tiles/middle_ground.png", tileable: true)

     (1..((Utils.get_width / bloque.width) / Utils::SCALE_FLOOR)).each do |index|
       @floor << index
     end

    @floor[@floor.index(@floor.first)] = Gosu::Image.new("media/images/levels/#{Utils.get_level}/tiles/left_ground.png", tileable: true)
    @floor[@floor.index(@floor.last)] = Gosu::Image.new("media/images/levels/#{Utils.get_level}/tiles/right_ground.png", tileable: true)

    (1..(@floor.length - 2)).each do |index|
      @floor[index] = Gosu::Image.new("media/images/levels/#{Utils.get_level}/tiles/middle_ground.png", tileable: true)
    end

    Utils.set_floor_y(Utils.get_height - (@floor.first.height * Utils::SCALE_FLOOR))
  end


  def draw
    @floor.each_with_index do |element, index|
      element.draw(64 * index, Utils.get_floor_y, 1, Utils::SCALE_FLOOR, Utils::SCALE_FLOOR)
    end
  end

  def get_y
    Utils.get_height - (@floor.first.height / 2)
  end

  def get_x
    @x
  end

  def get_width
    Utils.get_width
  end

  def get_height
    Utils.get_height
  end
end
