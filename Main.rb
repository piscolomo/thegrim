require 'chingu'
include Gosu
include Chingu

require_rel 'game_states/*'
require_rel 'game_objects/*'

class Game < Chingu::Window
  def initialize
    super(1000,768, false)
    push_game_state(Aboutus)
  end
end

Game.new.show
