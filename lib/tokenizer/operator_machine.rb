require_relative 'state_machine'
require_relative '../tokenizer/tokens/token'

class OperatorMachine < StateMachine
  def initialize
    super
    @operator = ""
    @supported_ops = {'=' => 'EQ', '<' => 'LT', '!' => 'NOT', '>' => 'GT', '!=' => 'NE', '==' => 'EQ-EQ'}
  end

  def input(x)
    if @supported_ops.keys.include? x
      if(!@operator.empty?)
        new_ope = @operator + x
        @supported_ops.keys.include?(new_ope)
        @operator = new_ope
      else
        @current_state = :final
        @operator = x
      end

    else
      @current_state = :dead
    end
    self
  end

  def val
    Token.new @supported_ops[@operator]
  end

  def reset_state
    super
    @operator = ""
  end
end
