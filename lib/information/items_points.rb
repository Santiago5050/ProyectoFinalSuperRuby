require 'gosu'

class ItemPoints

  def initialize(level, items = 1)
    @items = items
    case level
      when "LevelOne"
        @item = Gosu::Image.new("media/images/levels/1/items/snowman.png")
        @objetive_items = 10
        @scale = 0.4
      when "LevelTwo"
        @item = Gosu::Image.new("media/images/levels/2/items/skeleton.png")
        @objetive_items = 15
        @scale = 0.5
      when "LevelThree"
        if items == 1
          @item = Gosu::Image.new("media/images/levels/3/items/mushroom_1.png")
          @objetive_items = 15
          @scale = 0.7
        elsif items == 2
          @item_2 = Gosu::Image.new("media/images/levels/3/items/mushroom_2.png")
          @objetive_items2 = 10
          @scale = 0.7
        end
    end
    @take_items = 0
    @take_items2 = 0 if @items == 2
  end

  def draw
    if @items == 1
      @text = Gosu::Image.from_text("#{@take_items} / #{@objetive_items}", 40, font: Utils.default_font)
      @x_text = Utils.center_x(@text)
      @x_item = (@x_text + @text.width + 5)
      @text.draw(@x_text, 7, 1, 1, 1, Utils::TEXT_COLOR)
      @item.draw(@x_item, 9, 1, @scale, @scale,)
    elsif @items == 2
      @text_2 = Gosu::Image.from_text("#{@take_items2} / #{@objetive_items2}", 40, font: Utils.default_font, )
      @x_text_2 = Utils.center_x(@text_2) + 150
      @x_item_2 = (@x_text_2 + @text_2.width + 5)
      @text_2.draw(@x_text_2, 7, 1, 1, 1, Utils::TEXT_COLOR)
      @item_2.draw(@x_item_2, 9, 1, @scale, @scale)
    end
  end

  def take_item!(items)
    if items == 1
      @take_items += 1 if @take_items < @objetive_items
    elsif items == 2
      @take_items2 += 1 if @take_items2 < @objetive_items2
    end
  end

  def level_win?
    if @items == 1
      @take_items == @objetive_items
    elsif @items == 2
      @take_items2 == @objetive_items2
    end
  end

end
