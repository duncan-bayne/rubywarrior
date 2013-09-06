require_relative 'player_state.rb'

class Fighting < PlayerState

  def go(warrior)
    warrior.attack!
    super
  end

  def transition(warrior)
    flee(warrior) ||
      rest(warrior) ||
      walk(warrior) ||
      self
  end

end
