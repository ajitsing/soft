require_relative 'state_machine'
require_relative '../tokenizer/tokens/identifier_token'

class IdentifierMachine < StateMachine
  def initialize
    super
    @identifier = ""
  end

  def input(x)
    if x.eql? ' '
      @current_state = :dead
    else
      @identifier << x
      @current_state = :final
    end
    self
  end

  def val
    IdentifierToken.new @identifier
  end

  def reset_state
    super
    @identifier = ""
  end
end
