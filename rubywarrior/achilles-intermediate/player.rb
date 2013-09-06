require_relative 'fighting.rb'
require_relative 'player.rb'
require_relative 'walking.rb'

class Player

  def play_turn(warrior)

    unless @old_state
      @old_state = Walking.new
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

end
