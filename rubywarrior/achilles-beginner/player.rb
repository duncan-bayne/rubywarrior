require_relative 'fighting.rb'
require_relative 'fleeing.rb'
require_relative 'rescuing.rb'
require_relative 'resting.rb'
require_relative 'shooting.rb'
require_relative 'walking.rb'

class Player

  attr_accessor :direction

  def initialize
    self.direction = :backward
    super
  end

  def play_turn(warrior)

    unless @old_state
      @old_state = Walking.new(self)
    end

    @new_state = @old_state.transition(warrior)

    if @new_state != @old_state
      puts "transitions from #{@old_state.class} to #{@new_state.class}"
    else
      puts "continues #{@new_state.class}"
    end

    @new_state.go(warrior)
    @old_state = @new_state
  end

  def pivot!(warrior)
    puts "pivots"
    warrior.pivot!
  end

end
