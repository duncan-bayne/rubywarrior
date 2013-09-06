class PlayerState

  def facing_enemy?(warrior)
    warrior.feel(warrior.direction_of_stairs).enemy?
  end

  def walk(warrior)
    if !facing_enemy?(warrior)
      Walking.new
    else
      nil
    end
  end

  def fight(warrior)
    if facing_enemy?(warrior)
      Fighting.new
    else
      nil
    end
  end

end
