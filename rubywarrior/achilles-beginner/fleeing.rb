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
    fight(warrior) ||
      rest(warrior) ||
      walk(warrior) ||
      self
  end

end
