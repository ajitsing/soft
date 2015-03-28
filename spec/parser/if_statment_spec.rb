require 'spec_helper'

describe 'IfStatement' do
  it 'should return predicate of if statement' do
    id_token = IdentifierToken.new('b')
    id_token_2 = IdentifierToken.new('a')
    condition = Token.new('LT')
    if_statement = IfStatement.new(id_token, condition, id_token_2)

    if_statement.predicate.first.should == id_token
    if_statement.predicate[1].should == condition
    if_statement.predicate.last.should == id_token_2
  end
end
