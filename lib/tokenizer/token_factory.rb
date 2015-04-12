Dir["./lib/tokenizer/*machine.rb"].each {|file| require file }

class TokenFactory
  def initialize
    keyword_machines = %w(print class meth end if else while).map { |keyword| KeywordMachine.new(keyword) }

    @machines = [
        StringMachine.new,
        ExpressionMachine.new,
        IdentifierMachine.new,
        OperatorMachine.new,
        MethArgsMachine.new
    ] + keyword_machines
  end

  def raw_data(data)
    @machines.each { |machine| machine.input data }
    self
  end

  def get_token
    machine_in_final_state.val
  end

  def reset_machines
    @machines.each { |m| m.reset_state }
  end

  def any_machine_in_final_state?
    !machine_in_final_state.nil?
  end

  private
  def machine_in_final_state
    key_machine = @machines.select {|m| m.is_a? KeywordMachine and m.in_final_state?}.first
    string_machine = @machines.select {|m| m.is_a? StringMachine}.first
    expression_machine = @machines.select {|m| m.is_a? ExpressionMachine}.first
    identifier_machine = @machines.select {|m| m.is_a? IdentifierMachine}.first
    operator_machine = @machines.select {|m| m.is_a? OperatorMachine}.first
    meth_machine = @machines.select {|m| m.is_a? MethArgsMachine}.first

    #priority of machines
    if key_machine
      key_machine
    elsif meth_machine.in_final_state?
      meth_machine
    elsif string_machine.in_final_state?
      string_machine
    elsif expression_machine.in_final_state? and !string_machine.running?
      expression_machine
    elsif operator_machine.in_final_state?
      operator_machine
    elsif identifier_machine.in_final_state? and !(expression_machine.running? || string_machine.running?)
      identifier_machine
    end
  end
end
