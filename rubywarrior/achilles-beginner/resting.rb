require_relative 'player_state.rb'

class Resting < PlayerState

  def go(warrior)
    warrior.rest!
    super
  end

  def transition(warrior)
    flee(warrior) ||
      shoot(warrior) ||
      walk(warrior) ||
      fight(warrior) ||
      self
  end

end
