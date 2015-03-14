require_relative '../spec_helper'

describe :IdentifierMachine do
  it 'should be in :not_started state when no input is supplied' do
    IdentifierMachine.new.state.should == :not_started
  end

  it 'should be in :final state when the inputs are being supplied' do
    sm = IdentifierMachine.new
    sm.input('n').input('a').input('m').input('e')
    sm.state.should == :final
  end

  it 'should return the captured identifyer' do
    sm = IdentifierMachine.new
    sm.input('n').input('a').input('m').input('e').val.inspect.should == 'ID:name'
  end

  it 'should be in :dead state when input is a space' do
    sm = IdentifierMachine.new
    sm.input('v').input('a').input(' ')
    sm.state.should == :dead
  end
end
