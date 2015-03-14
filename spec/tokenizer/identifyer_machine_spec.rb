require_relative '../spec_helper'

describe :IdentifyerMachine do
  it 'should be in :not_started state when no input is supplied' do
    IdentifyerMachine.new.state.should == :not_started
  end

  it 'should be in :final state when the inputs are being supplied' do
    sm = IdentifyerMachine.new
    sm.input('n').input('a').input('m').input('e')
    sm.state.should == :final
  end

  it 'should return the captured identifyer' do
    sm = IdentifyerMachine.new
    sm.input('n').input('a').input('m').input('e').val.should == 'ID:name'
  end

  it 'should be in :dead state when input is a space' do
    sm = IdentifyerMachine.new
    sm.input('v').input('a').input(' ')
    sm.state.should == :dead
  end
end
