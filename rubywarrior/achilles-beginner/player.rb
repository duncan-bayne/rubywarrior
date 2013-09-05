class PlayerState

  def initialize(player)
    @player = player
    @previous_health = 20
  end

  def facing_captive?(warrior)
    warrior.feel.captive?
  end

  def facing_enemy?(warrior)
    warrior.feel.enemy?
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

class Rescuing < PlayerState

  def go(warrior)
    warrior.rescue!
    super
  end

  def transition(warrior)

    if !facing_captive?(warrior)
      return Walking.new(@player)
    end

    if wounded?(warrior) && !under_attack?(warrior)
      return Resting.new(@player)
    end

    self
  end

end

class Walking < PlayerState

  def go(warrior)
    warrior.walk!
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

    self
  end

end

class Fighting < PlayerState

  def go(warrior)
    warrior.attack!
    super
  end

  def transition(warrior)

    if wounded?(warrior) && !under_attack?(warrior)
      return Resting.new(@player)
    end

    if !wounded?(warrior) && !under_attack?(warrior)
      return Walking.new(@player)
    end

    self
  end

end

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

    self
  end

end

class Player

  def play_turn(warrior)

    unless @old_state
      @old_state = Walking.new(self)
    end

    @new_state = @old_state.transition(warrior)

    if @new_state != @old_state
      puts "transitioned from #{@old_state.class} to #{@new_state.class}"
    else
      puts "continue #{@new_state.class}"
    end

    @new_state.go(warrior)
    @old_state = @new_state
  end

end
