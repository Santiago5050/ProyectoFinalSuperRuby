require_relative 'lib/modules/utils'
require_relative 'lib/game'

Utils.set_resolution(1024, 600)

@game = Game.new
@game.show
