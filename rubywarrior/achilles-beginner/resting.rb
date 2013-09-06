require_relative 'player_state.rb'

class Resting < PlayerState

  def go(warrior)
    warrior.rest!
    super
  end

  def transition(warrior)

    if !wounded?(warrior) || under_attack?(warrior)
      return Walking.new(@player)
    end

    if facing_enemy?(warrior)
      return Fighting.new(@player)
    end

    if endangered?(warrior) && under_attack?(warrior)
      return Fleeing.new(@player)
    end

    self
  end

end
