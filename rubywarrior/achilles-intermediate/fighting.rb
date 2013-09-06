require_relative 'player_state.rb'

class Fighting < PlayerState
  def go(warrior)
    warrior.attack!(warrior.direction_of_stairs)
  end

  def transition(warrior)
    walk(warrior) || self
  end
end
