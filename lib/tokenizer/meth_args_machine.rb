require_relative 'state_machine'
require_relative '../tokenizer/tokens/identifier_token.rb'
require_relative '../tokenizer/tokens/token.rb'

class MethArgsMachine < StateMachine
  def initialize
    super
    @meth_args_exp = Regexp.new(/[a-zA-Z]+\((([a-zA-Z0-9]+[ ]*,)+[ ]*)+[a-zA-Z0-9]+\)/)
    @input = ""
  end

  def input(x)
    @input << x
    @current_state = :running
    self
  end

  def in_final_state?
    !@meth_args_exp.match(@input).nil?
  end

  def reset_state
    super
    @input = ""
  end

  def val
    args = @input.split('(')[1].chop
    tokens = args.split(',').map { |x| IdentifierToken.new(x.strip) }
    [Token.new('O_PARAN')] + tokens + [Token.new('C_PARAN')]
  end
end
