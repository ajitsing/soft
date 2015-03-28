require 'spec_helper'

describe 'IfStatment' do
  it 'should return predicate of if statment' do
    id_token = IdentifierToken.new('b')
    key_token = KeywordToken.new('if')
    id_token_2 = IdentifierToken.new('a')
    condition = Token.new('LT')
    if_statment = IfStatment.new([key_token, id_token, condition, id_token_2])

    if_statment.predicate.first.should == id_token
    if_statment.predicate[1].should == condition
    if_statment.predicate.last.should == id_token_2
  end
end
