require_relative 'player_state.rb'

class Walking < PlayerState

  def go(warrior)
    if facing_wall?(warrior)
      @player.pivot!(warrior)
    else
      warrior.walk!
    end

    super
  end

  def transition(warrior)

    if facing_enemy?(warrior)
      return Fighting.new(@player)
    end

    if facing_captive?(warrior)
      return Rescuing.new(@player)
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
