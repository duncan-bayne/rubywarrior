require_relative 'player_state.rb'

class Shooting < PlayerState

  def go(warrior)
    warrior.shoot!
    super
  end

  def transition(warrior)

    if endangered?(warrior) && under_attack?(warrior)
      return Fleeing.new(@player)
    end

    if wounded?(warrior) && !under_attack?(warrior)
      return Resting.new(@player)
    end

    if !enemy_ahead?(warrior)
      return Walking.new(@player)
    end

    self

  end
end
