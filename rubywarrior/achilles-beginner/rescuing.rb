require_relative 'player_state.rb'

class Rescuing < PlayerState

  def go(warrior)
    warrior.rescue!
    super
  end

  def transition(warrior)
    flee(warrior) ||
      shoot(warrior) ||
      walk(warrior) ||
      rest(warrior) ||
      self
  end

end
