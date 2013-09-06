require_relative 'player_state.rb'

class Shooting < PlayerState

  def go(warrior)
    warrior.shoot!(choose_target(warrior))
    super
  end

  def transition(warrior)
    flee(warrior) ||
      rest(warrior) ||
      walk(warrior) ||
      self
  end
end
