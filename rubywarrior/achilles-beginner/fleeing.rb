require_relative 'player_state.rb'

class Fleeing < PlayerState

  def go(warrior)
    if !@pivoted
      @player.pivot!(warrior)
      @pivoted = true
    else
      warrior.walk!
    end

    super
  end

  def transition(warrior)

    if wounded?(warrior) && !under_attack?(warrior)
      return Resting.new(@player)
    end

    if !wounded?(warrior)
      return Walking.new(@player)
    end

    self
  end

end
