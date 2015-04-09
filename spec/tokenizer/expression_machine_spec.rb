require 'spec_helper'

describe :ExpressionMachine do
  it 'should be in :not_started state when no input is supplied' do
    ExpressionMachine.new.state.should == :not_started
  end

  it 'should be in :running state when input is mathematical operator' do
    ExpressionMachine.new.input('1').input('+').state.should == :running
  end

  it 'should return the expression' do
    ExpressionMachine.new.input('1').input('+').input('1').val.inspect.should == 'EXP:1+1'
  end

  it 'should be in :final state when input is number with mathematical operators' do
    ExpressionMachine.new.input('1').input('+').input('1').state.should == :final
  end

  it 'should return true when expression has mathematical ops' do
    ExpressionMachine.new.input('1').input('+').input('1').has_mathematical_ops?.should be_true
  end

  it 'should be in :final state when input is number' do
    ExpressionMachine.new.input('1').state.should == :final
  end

  it 'should be in :final state when input is multiple numbers' do
    ExpressionMachine.new.input('1').input('2').state.should == :final
  end

  it 'should be in :final state when input has brackets' do
    machine = ExpressionMachine.new.input('(').input('1').input(')')
    machine.state.should == :final
    machine.val.inspect.should == 'EXP:(1)'
  end

  it 'should be in :final state when input is numbers with airthematic operations' do
    machine = ExpressionMachine.new.input('1').input('+').input('2').input('*').input('3')

    machine.state.should == :final
    machine.val.inspect.should == 'EXP:1+2*3'
  end

  it 'should be in :running state when input is ending with mathematical operator' do
    machine = ExpressionMachine.new.input('1').input('+').input('2').input('*')
    machine.state.should == :running
  end
end
