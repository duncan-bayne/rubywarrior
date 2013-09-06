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
    flee(warrior) ||
      fight(warrior) ||
      shoot(warrior) ||
      resque(warrior) ||
      rest(warrior) ||
      self
  end
end
