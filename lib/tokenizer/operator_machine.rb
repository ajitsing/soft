require_relative 'state_machine'

class OperatorMachine < StateMachine
  def initialize
    super
    @operator = ""
    @supported_ops = {'=' => 'EQ', '<' => 'LT', '>' => 'GT', '!' => 'NE'}
  end

  def input(x)
    if @supported_ops.keys.include? x
      @current_state = :final
      @operator = x
    else
      @current_state = :dead
    end
    self
  end

  def val
    @supported_ops[@operator]
  end

  def reset_state
    super
    @operator = ""
  end
end
