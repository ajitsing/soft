require 'spec_helper'

describe :TokenFactory do
  it 'should return :print token' do
    factory = TokenFactory.new
    factory.raw_data('p').raw_data('r').raw_data('i').raw_data('n').raw_data('t')
    factory.get_token.inspect.should == 'KEY:print'
  end

  it 'should return string value when the token is string' do
    factory = TokenFactory.new
    factory.raw_data("\"").raw_data('c').raw_data('o').raw_data('o').raw_data('l').raw_data("\"")
    factory.get_token.inspect.should == 'STRING:cool'
  end

  it 'should return expression when the token is a expression' do
    factory = TokenFactory.new
    factory.raw_data("2").raw_data("1")
    factory.get_token.inspect.should == 'EXP:21'
  end
end
