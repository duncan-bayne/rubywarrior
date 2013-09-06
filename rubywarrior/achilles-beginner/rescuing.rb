require_relative 'player_state.rb'

class Rescuing < PlayerState

  def go(warrior)
    warrior.rescue!
    super
  end

  def transition(warrior)

    if !facing_captive?(warrior)
      return Walking.new(@player)
    end

    if wounded?(warrior) && !under_attack?(warrior)
      return Resting.new(@player)
    end

    if endangered?(warrior) && under_attack?(warrior)
      return Fleeing.new(@player)
    end

    self
  end

end
