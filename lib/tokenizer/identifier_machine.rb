require_relative 'state_machine'
require_relative '../tokenizer/tokens/identifier_token'
require_relative '../tokenizer/tokens/meth_call_token'
require_relative '../tokenizer/tokens/new_obj_token'

class IdentifierMachine < StateMachine
  def initialize
    super
    @identifier = ""
  end

  def input(x)
    if [' ', "\n", "\t"].include? x
      @current_state = :dead
      @identifier = ""
    else
      @identifier << x
      @current_state = :final
    end
    self
  end

  def in_final_state?
    @current_state == :final and !@identifier.empty?
  end

  def val
    if @identifier.end_with? '()' and @identifier.chars.include? '.'
      MethCallToken.new @identifier
    elsif @identifier.end_with? '()'
      NewObjToken.new @identifier
    else
      IdentifierToken.new @identifier
    end
  end

  def reset_state
    super
    @identifier = ""
  end
end
