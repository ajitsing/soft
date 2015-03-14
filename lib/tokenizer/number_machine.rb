class NumberMachine < StateMachine
  def initialize
    super
    @number = ""
    @regexp = Regexp.new("[0-9]")
  end

  def input(x)
    if !@regexp.match(x).nil?
      @current_state = :final
      @number << x
    else
      @current_state = :dead
    end
    self
  end

  def val
    'NUM:' + @number
  end

  def reset_state
    @number = ""
  end
end
