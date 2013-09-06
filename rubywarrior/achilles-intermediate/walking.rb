require_relative 'player_state.rb'

class Walking < PlayerState
  def go(warrior)
    warrior.walk!(warrior.direction_of_stairs)
  end

  def transition(warrior)
    fight(warrior) || self
  end
end
