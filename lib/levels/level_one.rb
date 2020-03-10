require 'gosu'
require_relative 'level'
require_relative '../characters/enemies/lantern'

class LevelOne < Level

  def initialize(lifes, points, selected_player)
    Utils.set_level(1)
    super(lifes, points, selected_player)
    @enemies_lantern = []
    @items_snowman = []
    @items_life = []
    @music = Gosu::Song.new('media/sounds/music/level_1.ogg')
  end

  def draw
    super
    draw_element(@enemies_lantern, "Enemy")
    draw_element(@items_snowman)
    draw_element(@items_life)
  end

  def update(id)
     super(id)
     @music.play if Utils.get_sound_option == 0 && Utils.get_music_option == 2

     @enemies_lantern = update_element(@enemies_lantern, 5, 25, Lantern, nil)
     enemies_collision(@enemies_lantern, 20)
     enemies_jump_time(@enemies_lantern)
     enemies_move(@enemies_lantern)

     @items_snowman = update_element(@items_snowman, 0, 20, Items, self.class.name)
     items_collision(@items_snowman, 10, "Element")
     update_items(@items_snowman)

     @items_life = update_element(@items_life, 0, 4, Items, "Life")
     items_collision(@items_life, Random.rand(300..500), "Life")
     update_items(@items_life)

  end

end
