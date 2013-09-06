class PlayerState

  def initialize(player)
    @player = player
    @previous_health = 20
  end

  def endangered?(warrior)
    warrior.health < 14
  end

  def path_clear?(warrior, direction = :forward)
    warrior.look.all? { |space| space.empty? }
  end

  def look_for_enemy?(warrior, direction = :forward, unit = nil)
    sees = warrior.look(direction)

    warrior.look(direction).each do |space|
      if space.captive?
        return false
      end

      if space.enemy? && (unit == nil || space.unit.class == unit)
        return true
      end
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

  def flee(warrior)
    if endangered?(warrior) && under_attack?(warrior) && path_clear?(warrior, :behind)
      Fleeing.new(@player)
    else
      nil
    end
  end

  def rest(warrior)
    if wounded?(warrior) && !under_attack?(warrior) && !look_for_enemy?(warrior)
      Resting.new(@player)
    else
      nil
    end
  end

  def walk(warrior)
    if !wounded?(warrior) && !under_attack?(warrior) && !look_for_enemy?(warrior)
      Walking.new(@player)
    else
      nil
    end
  end

  def fight(warrior)
    if facing_enemy?(warrior)
      Fighting.new(@player)
    else
      nil
    end
  end

  def shoot(warrior)
    direction = choose_target(warrior)
    if direction
      Shooting.new(@player)
    else
      nil
    end
  end

  def resque(warrior)
    if facing_captive?(warrior)
      Rescuing.new(@player)
    else
      nil
    end
  end

  def choose_target(warrior)
    if look_for_enemy?(warrior, :forward, RubyWarrior::Units::Archer)
      :forward
    elsif look_for_enemy?(warrior, :backward, RubyWarrior::Units::Archer)
      :backward
    elsif look_for_enemy?(warrior, :forward)
      :forward
    elsif look_for_enemy?(warrior, :backward)
      :backward
    else
      nil
    end
  end

end
