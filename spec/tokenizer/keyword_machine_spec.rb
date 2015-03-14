require_relative '../spec_helper'

describe :KeywordMachine do
  it 'should be in :not_started state when no input is supplied' do
    KeywordMachine.new("abc").state.should == :not_started
  end

  it 'should be in :running state when the inputs are being supplied' do
    sm = KeywordMachine.new("abc")
    sm.input('a').input('b')
    sm.state.should == :running
  end

  it 'should be in :final state when inputs are over and machine is in final state' do
    sm = KeywordMachine.new("abc")
    sm.input('a').input('b').input('c')
    sm.state.should == :final
  end

  it 'should be in :dead state when wrong input is supplied at the end' do
    sm = KeywordMachine.new("abc")
    sm.input('a').input('b').input('c').input('d')
    sm.state.should == :dead
  end

  it 'should be in :dead state when wrong input is supplied in the middle' do
    sm = KeywordMachine.new("abc")
    sm.input('a').input('c')
    sm.state.should == :dead
  end

  it 'should be in :dead state when wrong input is supplied in the start' do
    sm = KeywordMachine.new("abc")
    sm.input('c')
    sm.state.should == :dead
  end
end
