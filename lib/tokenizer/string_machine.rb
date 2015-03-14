require_relative 'state_machine'

class StringMachine < StateMachine
  def initialize
    super
    @string = ""
  end

  def input(x)
    return if halted?

    if double_quote?(x) and (!running? || not_started?)
      @current_state = :running
    elsif double_quote?(x) and running?
      @current_state = :final
    elsif in_final_state?
      @current_state = :halt
    else
      @string << x
    end

    self
  end

  def val
    'STRING:' + @string
  end

  def reset_state
    super
    @string = ""
  end

  private
  def double_quote?(x)
    x == "\""
  end
end
