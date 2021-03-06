require_relative 'level'
require_relative '../characters/enemies/lantern'
require_relative '../characters/enemies/knight'
class LevelFour < Level
<<<<<<< HEAD
  def initialize(lifes, points)
    Utils.set_level(4)
    super(lifes, points)
=======
  def initialize(lifes, points, selected_player)
    Utils.set_level(2)
    super(lifes, points, selected_player)
>>>>>>> 9bc6f888bf75e08d470db27e3abcbeaec2b4d8c1
    @enemies_lantern = []
    @enemies_knight = []
    @items_skeleton = []

    @items_life = []
    @music = Gosu::Song.new('media/sounds/music/level_4.ogg')
  end

  def update(id)
     super(id)
     @music.play if Utils.get_sound_option == 0 && Utils.get_music_option == 2

     @enemies_lantern = update_element(@enemies_lantern, 3, 15, Lantern, nil)
     enemies_collision(@enemies_lantern, 10)
     enemies_jump_time(@enemies_lantern)
     enemies_move(@enemies_lantern)

     @enemies_knight = update_element(@enemies_knight, 5, 25, Knight, nil)
     enemies_collision(@enemies_knight, 30)
     enemies_jump_time(@enemies_knight)
     enemies_move(@enemies_knight)

     @items_life = update_element(@items_life, 0, 4, Items, "Life")
     items_collision(@items_life, Random.rand(300..500), "Life")
     update_items(@items_life)

  end

  def draw
    super
    draw_element(@enemies_lantern, "Enemy")
    draw_element(@enemies_knight, "Enemy")
    draw_element(@enemies_ninja, "Enemy")
    draw_element(@items_life)
    @kunais.each do |element|
      element.draw
    end
    update_kunais
  end
  def screen_status
    {
      status: @status,
      score: @score,
      lives: @level_life_points,
      items: @item_points,
      lifes: @level_life_points.lifes
    }
  end

end
