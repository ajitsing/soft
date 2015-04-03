require 'spec_helper'
require 'pry'

describe 'Parser' do
  it 'should parse an empty block' do
    Parser.new.to_statements([]).should == []
  end

  it 'should parse print statement' do
    tokens = [KeywordToken.new('print'), StringToken.new("Ajit")]
    statements = Parser.new.to_statements(tokens)

    statements.first.class.should == PrintStatement
    statements.first.value.should == "Ajit"
    statements.size.should == 1
  end

  it 'should parse assignment statement' do
    tokens = [IdentifierToken.new('name'),Token.new('EQ'), StringToken.new("Ajit")]
    statements = Parser.new.to_statements(tokens)

    statements.first.class.should == AssignmentStatement
    statements.size.should == 1
  end

  it 'should parse if statement' do
    tokens = [KeywordToken.new('if'),IdentifierToken.new('name'), Token.new('EQ-EQ'), StringToken.new("Ajit"), KeywordToken.new('end')]
    statements = Parser.new.to_statements(tokens)

    statements.first.class.should == IfStatement
    statements[1].class.should == EndStatement
    statements.size.should == 2
  end

  it 'should parse if statement with block' do
    tokens = [KeywordToken.new('if'),IdentifierToken.new('name'), Token.new('EQ-EQ'), StringToken.new("Ajit"),
              KeywordToken.new('print'), StringToken.new("Ajit"), KeywordToken.new('end')]
    statements = Parser.new.to_statements(tokens)

    statements.first.class.should == IfStatement
    statements[1].class.should == PrintStatement
    statements[1].value.should == 'Ajit'
    statements[2].class.should == EndStatement
    statements.size.should == 3
  end

  it 'should parse while statement' do
    tokens = [KeywordToken.new('while'),IdentifierToken.new('number'), Token.new('LT'), ExpressionToken.new("5")]
    statements = Parser.new.to_statements(tokens)

    statements.first.class.should == WhileStatement
    statements.size.should == 1
  end

  it 'should parse while statement with block' do
    tokens = [KeywordToken.new('while'),IdentifierToken.new('number'), Token.new('LT'), ExpressionToken.new("5"),
              KeywordToken.new('print'), StringToken.new("Ajit"), KeywordToken.new('end')]
    statements = Parser.new.to_statements(tokens)

    statements.size.should == 3
  end

  it 'integration spec' do
    source_code = <<-CODE
      if a < b
        print a
        if a < b
          print b
        end
      end
    CODE

    tokens = Scanner.tokenize source_code
    statements = Parser.new.to_statements(tokens)
    statements
  end
end
