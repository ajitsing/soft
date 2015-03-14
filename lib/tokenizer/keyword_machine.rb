require_relative 'state_machine'

class KeywordMachine < StateMachine
  def initialize(keyword)
    super()
    @keyword = keyword
    @states = keyword.chars
  end

  def input(x)
    if @states.first == x
      @states = @states[1..-1]
      @current_state = :running
      put_in_final_state?
    else
      @current_state = :dead
    end
    self
  end

  def val
    'KEY:' + @keyword
  end

  def reset_state
    super
    @states = @keyword.chars
  end

  private
  def put_in_final_state?
    if @states.empty?
      @current_state = :final
    end
  end
end
