class PlayerState

  def initialize(player)
    @player = player
    @previous_health = 20
  end

  def endangered?(warrior)
    warrior.health < 14
  end

  def enemy_ahead?(warrior)
    warrior.look.each do |space|
      return false if space.captive?
      return true if space.enemy?
    end

    false
  end

  def facing_captive?(warrior)
    warrior.feel.captive?
  end

  def facing_enemy?(warrior)
    warrior.feel.enemy?
  end

  def facing_wall?(warrior)
    warrior.feel.wall?
  end

  def go(warrior)
    @previous_health = warrior.health
  end

  def under_attack?(warrior)
    warrior.health < @previous_health
  end

  def wounded?(warrior)
    warrior.health < 20
  end

end
