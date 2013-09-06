require_relative 'player_state.rb'

class Fighting < PlayerState

  def go(warrior)
    warrior.attack!
    super
  end

  def transition(warrior)

    if wounded?(warrior) && !under_attack?(warrior)
      return Resting.new(@player)
    end

    if endangered?(warrior) && under_attack?(warrior)
      return Fleeing.new(@player)
    end

    if !wounded?(warrior) && !under_attack?(warrior)
      return Walking.new(@player)
    end

    if endangered?(warrior) && under_attack?(warrior)
      return Fleeing.new(@player)
    end

    self
  end

end
