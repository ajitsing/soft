Dir["./lib/tokenizer/*machine.rb"].each {|file| require file }

class TokenFactory
  def initialize
    identifier_machine = IdentifierMachine.new
    string_machine = StringMachine.new
    expression_machine = ExpressionMachine.new
    operator_machine = OperatorMachine.new
    keyword_machines = ['print', 'class', 'meth', 'end', 'if'].map { |keyword| KeywordMachine.new(keyword) }

    @machines = [string_machine, expression_machine, identifier_machine, operator_machine] + keyword_machines
  end

  def raw_data(data)
    @machines.each do |machine|
      machine.input data
    end
    self
  end

  def get_token
    machine_in_final_state.val
  end

  def machine_states
    @machines.each { |m| p m, m.state }
  end

  def reset_machines
    @machines.each { |m| m.reset_state }
  end

  def any_machine_in_final_state?
    !machine_in_final_state.nil?
  end

  def expression_machine_is_running?
    !@machines.select { |machine| machine.running? and machine.is_a? ExpressionMachine }.first.nil?
  end

  private
  def machine_in_final_state
    key_machine = @machines.select {|m| m.is_a? KeywordMachine and m.in_final_state?}.first
    string_machine = @machines.select {|m| m.is_a? StringMachine}.first
    expression_machine = @machines.select {|m| m.is_a? ExpressionMachine}.first
    identifier_machine = @machines.select {|m| m.is_a? IdentifierMachine}.first
    operator_machine = @machines.select {|m| m.is_a? OperatorMachine}.first

    #priority of machines
    if key_machine
      key_machine
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
