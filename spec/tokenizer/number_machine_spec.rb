require_relative '../spec_helper'

describe :NumberMachine do
  it 'should be in :not_started state when no input is supplied' do
    NumberMachine.new.state.should == :not_started
  end

  it 'should be in :final state when a number is supplied' do
    NumberMachine.new.input("1").state.should == :final
  end

  it 'should return the number' do
    NumberMachine.new.input("1").val.should == 'NUM:1'
  end

  it 'should be in :final state when multiple numbers are supplied' do
    NumberMachine.new.input("1").input("2").input("3").state.should == :final
  end

  it 'should be in :dead state when input is not a number' do
    NumberMachine.new.input("1").input("B").state.should == :dead
  end
end
