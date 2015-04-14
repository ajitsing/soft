require_relative '../spec_helper'

describe :StringMachine do
  it 'should be in :final state when empty string is given' do
    sm = Soft::StringMachine.new.input("\"").input("\"")
    sm.in_final_state?.should == true
  end

  it 'should be in :final state when right string is given' do
    sm = Soft::StringMachine.new.input("\"").input("a").input("b").input("\"")
    sm.in_final_state?.should == true
    sm.val.inspect.should == "STRING:ab"
  end

  it 'should be in :running state when string is not closed' do
    sm = Soft::StringMachine.new.input("\"").input("a")
    sm.running?.should == true
  end

  it 'should be in :not_started state when string is given' do
    sm = Soft::StringMachine.new.input("fjskl").input("a")
    sm.not_started?.should == true
  end

  it 'should be in :halt state when string is closed and more input supplied' do
    sm = Soft::StringMachine.new.input("\"").input("a").input("b").input("\"").input("k")
    sm.halted?.should == true
  end
end
