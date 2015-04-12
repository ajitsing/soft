require_relative '../spec_helper'

describe :MethArgsMachine do
  it 'should be in :final state when input is correct' do
    #a(num1,n2)
    machine = MethArgsMachine.new
                  .input('a').input('(')
                  .input('n').input('u').input('m').input('1').input(',')
                  .input('n').input('2')
                  .input(')')

    machine.in_final_state?.should == true
    machine.val.map {|x| x.inspect }.should == %w(ID:a ID:num1 ID:n2)
  end

  it 'should be in :running state when input is not ended with closing paren' do
    #a(num1,n2
    MethArgsMachine.new.input('a').input('(')
        .input('n').input('u').input('m').input('1').input(',')
        .input('n').input('2')
        .in_final_state?.should == false
  end

  it 'should be in :running state when input is not complete' do
    #a(num1,n2,
    MethArgsMachine.new.input('a').input('(')
        .input('n').input('u').input('m').input('1').input(',')
        .input('n').input(',')
        .in_final_state?.should == false
  end
end
