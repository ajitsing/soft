require_relative 'state_machine'
require_relative '../tokenizer/tokens/expression_token'

class ExpressionMachine < StateMachine
  def initialize
    super
    @expression = ""
    @regexp = Regexp.new("[0-9]")
    @mathematical_operators = ['+', '-', '*', '/', '%']
  end

  def input(x)
    if !@regexp.match(x).nil? or x == ')'
      @current_state = :final
      @expression << x
    elsif x == '-' or (@mathematical_operators.include? x and !@expression.empty?) or (x == '(')
      @current_state = :running
      @expression << x
    else
      @current_state = :dead
    end
    self
  end

  def val
    ExpressionToken.new @expression
  end

  def has_mathematical_ops?
    !@expression.chars.select {|c| @mathematical_operators.include? c}.empty?
  end

  def reset_state
    @expression = ""
  end
end
