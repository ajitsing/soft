Dir["./lib/tokenizer/*machine.rb"].each {|file| require file }
require 'pry'

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
    machines = @machines.select { |machine| machine.in_final_state? }
    running = @machines.select do |machine|
      (machine.is_a?(StringMachine) || machine.is_a?(ExpressionMachine)) and machine.running?
    end

    key_machine = machines.select {|m| m.is_a? KeywordMachine}.first
    string_machine = machines.select {|m| m.is_a? StringMachine}.first
    expression_machine = machines.select {|m| m.is_a? ExpressionMachine}.first
    identifier_machine = machines.select {|m| m.is_a? IdentifierMachine}.first
    operator_machine = machines.select {|m| m.is_a? OperatorMachine}.first

    #priority of machines
    if !key_machine.nil?
      key_machine
    elsif !string_machine.nil?
      string_machine
    elsif !expression_machine.nil? and @machines.select {|m| m.is_a?(StringMachine) and m.running?}.first.nil?
      expression_machine
    elsif !operator_machine.nil?
      operator_machine
    elsif !identifier_machine.nil? and running.empty?
      identifier_machine
    end
  end
end
