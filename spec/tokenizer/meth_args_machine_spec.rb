require_relative '../spec_helper'

describe :MethArgsMachine do
  it 'should be in :final state when input is correct' do
    MethArgsMachine.new.input('a').input('(').input('n').input('u').input('m').input('1').input(',').input('n').input('2').input(')').in_final_state?.should == true
  end

  it 'should be in :running state when input is not ended with closing paren' do
    MethArgsMachine.new.input('a').input('(').input('n').input('u').input('m').input('1').input(',').input('n').input('2').in_final_state?.should == false
  end

  it 'should be in :running state when input is not complete' do
    MethArgsMachine.new.input('a').input('(').input('n').input('u').input('m').input('1').input(',').input('n').input(',').in_final_state?.should == false
  end
end
