require_relative 'level'
require_relative '../characters/enemies/lantern'
require_relative '../characters/enemies/knight'
require_relative '../characters/enemies/ninja'

class LevelThree < Level

  def initialize(lifes, points, selected_player)
    Utils.set_level(3)
    super(lifes, points, selected_player)
    @item_points = ItemPoints.new(self.class.name, 1)
    @item_points_2 = ItemPoints.new(self.class.name, 2)
    @enemies_lantern = []
    @enemies_knight = []
    @enemies_ninja = []
    @kunais = []
    @items_pink_mushroom = []
    @items_orange_mushroom = []
    @items_life = []
    @music = Gosu::Song.new('media/sounds/music/level_3.ogg')
  end

  def draw
    super
    @item_points_2.draw
    draw_element(@enemies_lantern, "Enemy")
    draw_element(@enemies_knight, "Enemy")
    draw_element(@enemies_ninja, "Enemy")
    draw_element(@items_pink_mushroom)
    draw_element(@items_orange_mushroom)
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
      win: @item_points_2.level_win? && @item_points.level_win?,
      lifes: @level_life_points.lifes
    }
  end

  def update(id)
     super(id)
     @music.play if Utils.get_sound_option == 0 && Utils.get_music_option == 2

     @enemies_lantern = update_element(@enemies_lantern, 3, 15, Lantern, nil)
     enemies_collision(@enemies_lantern, 10)
     enemies_jump_time(@enemies_lantern)
     enemies_move(@enemies_lantern)

     @enemies_knight = update_element(@enemies_knight, 2, 15, Knight, nil)
     enemies_collision(@enemies_knight, 30)
     enemies_jump_time(@enemies_knight)
     enemies_move(@enemies_knight)

     @enemies_ninja = update_element(@enemies_ninja, 5, 25, Ninja, nil)
     enemies_collision(@enemies_ninja, 30)
     enemies_jump_time(@enemies_ninja)
     enemies_move(@enemies_ninja)
     collision_kunai


     @items_pink_mushroom = update_element(@items_pink_mushroom, 0, 25, Items, self.class.name, 1)
     items_collision(@items_pink_mushroom, 30, "Element", 1, @item_points)
     update_items(@items_pink_mushroom)

     @items_orange_mushroom = update_element(@items_orange_mushroom, 0, 15, Items, self.class.name, 2)
     items_collision(@items_orange_mushroom, 30, "Element", 2, @item_points_2)
     update_items(@items_orange_mushroom)

     @items_life = update_element(@items_life, 0, 4, Items, "Life")
     items_collision(@items_life, Random.rand(300..500), "Life")
     update_items(@items_life)
   end

   def update_kunais
     @enemies_ninja.each do |element|
       if element.shoot_kunai != false
         @kunais << element.shoot_kunai
       end
     end
     i = 0
     (0..(@kunais.length - 1)).each do |index|
       if @kunais[index - i].erase?
         @kunais.delete_at(index - i)
         i += 1
       end
     end
   end

   def collision_kunai
     unless @player.dead || @player.ghost
       i = 0
       (0..(@kunais.length - 1)).each do |index|
         collisions = collision?(@player, @kunais[index - i])
         if collisions[:all]
           @bip[:player_kill].play if Utils.get_effect_sounds_option == 4 && Utils.get_sound_option == 0
           @level_life_points.lost_life!
           @player.kill_character!(Gosu::milliseconds)
           @kunais.delete_at(index - i)
           i += 1
         end
       end
     end
   end
end
