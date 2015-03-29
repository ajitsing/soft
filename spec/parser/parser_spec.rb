require 'spec_helper'
require 'pry'

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
    tokens = [KeywordToken.new('if'),IdentifierToken.new('name'), Token.new('EQ-EQ'), StringToken.new("Ajit"), KeywordToken.new('end')]
    block = Parser.new.parse(tokens)

    block.statements.first.class.should == IfStatement
    block.statements.size.should == 1
  end

  it 'should parse if statement with block' do
    tokens = [KeywordToken.new('if'),IdentifierToken.new('name'), Token.new('EQ-EQ'), StringToken.new("Ajit"),
              KeywordToken.new('print'), StringToken.new("Ajit"), KeywordToken.new('end')]
    block = Parser.new.parse(tokens)

    block.statements.first.class.should == IfStatement
    block.statements.first.block.statements.first.class.should == PrintStatement
    block.statements.first.block.statements.first.value.should == 'Ajit'
    block.statements.size.should == 1
  end

  it 'should parse while statement' do
    tokens = [KeywordToken.new('while'),IdentifierToken.new('number'), Token.new('LT'), ExpressionToken.new("5")]
    block = Parser.new.parse(tokens)

    block.statements.first.class.should == WhileStatement
    block.statements.size.should == 1
  end

  it 'should parse while statement with block' do
    tokens = [KeywordToken.new('while'),IdentifierToken.new('number'), Token.new('LT'), ExpressionToken.new("5"),
              KeywordToken.new('print'), StringToken.new("Ajit"), KeywordToken.new('end')]
    block = Parser.new.parse(tokens)

    block.statements.first.class.should == WhileStatement
    block.statements.first.block.statements.first.class.should == PrintStatement
    block.statements.first.block.statements.first.value.should == 'Ajit'
    block.statements.size.should == 1
  end

  it 'integration spec' do
    source_code = <<-CODE
      a = 10
      b = 20
      if a < b
        print a
      end
      print "Ajit"
    CODE

    tokens = Scanner.tokenize source_code
    block = Parser.new.parse(tokens)
    block.print
  end
end
