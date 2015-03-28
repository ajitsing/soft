require 'spec_helper'

describe 'Parser' do
  it 'should parse an empty block' do
    Parser.new.parse([]).statements.should == Block.new.statements
  end

  it 'should parse print statement' do
    tokens = [KeywordToken.new('print'), StringToken.new("Ajit")]
    block = Parser.new.parse(tokens)

    block.statements.first.value.should == "Ajit"
    block.statements.size.should == 1
  end

  it 'should parse assignment statement' do
    tokens = [IdentifierToken.new('name'),Token.new('EQ'), StringToken.new("Ajit")]
    block = Parser.new.parse(tokens)

    block.statements.first.class.should == AssignmentStatement
    block.statements.size.should == 1
  end

  it 'should parse if statement' do
    tokens = [KeywordToken.new('if'),IdentifierToken.new('name'), Token.new('EQ-EQ'), StringToken.new("Ajit")]
    block = Parser.new.parse(tokens)

    block.statements.first.class.should == IfStatement
    block.statements.size.should == 1
  end

  it 'should parse while statement' do
    tokens = [KeywordToken.new('while'),IdentifierToken.new('number'), Token.new('LT'), ExpressionToken.new("5")]
    block = Parser.new.parse(tokens)

    block.statements.first.class.should == WhileStatement
    block.statements.size.should == 1
  end
end
