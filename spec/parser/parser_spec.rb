require 'spec_helper'

describe 'Soft::Parser' do
  it 'should parse an empty block' do
    Soft::Parser.new.to_statements([]).should == []
  end

  it 'should parse print statement' do
    tokens = [Soft::KeywordToken.new('print'), Soft::StringToken.new('Ajit')]
    statements = Soft::Parser.new.to_statements(tokens)

    statements.first.class.should == Soft::PrintStatement
    statements.first.value.should == 'Ajit'
    statements.size.should == 1
  end

  it 'should parse assignment statement' do
    tokens = [Soft::IdentifierToken.new('name'),Soft::Token.new('EQ'), Soft::StringToken.new('Ajit')]
    statements = Soft::Parser.new.to_statements(tokens)

    statements.first.class.should == Soft::AssignmentStatement
    statements.size.should == 1
  end

  it 'should parse if statement' do
    tokens = [Soft::KeywordToken.new('if'),Soft::IdentifierToken.new('name'), Soft::Token.new('EQ-EQ'), Soft::StringToken.new("Ajit"), Soft::KeywordToken.new('end')]
    statements = Soft::Parser.new.to_statements(tokens)

    statements.first.class.should == Soft::IfStatement
    statements[1].class.should == Soft::EndStatement
    statements.size.should == 2
  end

  it 'should parse if statement with block' do
    tokens = [Soft::KeywordToken.new('if'),Soft::IdentifierToken.new('name'), Soft::Token.new('EQ-EQ'), Soft::StringToken.new("Ajit"),
              Soft::KeywordToken.new('print'), Soft::StringToken.new("Ajit"), Soft::KeywordToken.new('end')]
    statements = Soft::Parser.new.to_statements(tokens)

    statements.first.class.should == Soft::IfStatement
    statements[1].class.should == Soft::PrintStatement
    statements[1].value.should == 'Ajit'
    statements[2].class.should == Soft::EndStatement
    statements.size.should == 3
  end

  it 'should parse while statement' do
    tokens = [Soft::KeywordToken.new('while'),Soft::IdentifierToken.new('number'), Soft::Token.new('LT'), Soft::ExpressionToken.new("5")]
    statements = Soft::Parser.new.to_statements(tokens)

    statements.first.class.should == Soft::WhileStatement
    statements.size.should == 1
  end

  it 'should parse while statement with block' do
    tokens = [Soft::KeywordToken.new('while'),Soft::IdentifierToken.new('number'), Soft::Token.new('LT'), Soft::ExpressionToken.new("5"),
              Soft::KeywordToken.new('print'), Soft::StringToken.new("Ajit"), Soft::KeywordToken.new('end')]
    statements = Soft::Parser.new.to_statements(tokens)

    statements.size.should == 3
  end

  it 'should parse method statement' do
    tokens = [Soft::KeywordToken.new('meth'),Soft::IdentifierToken.new('add'), Soft::KeywordToken.new('end')]
    statements = Soft::Parser.new.to_statements(tokens)

    statements.size.should == 2
    statements.first.class.should == Soft::MethodStatement
    statements[1].class.should == Soft::EndStatement
  end

  it 'should parse method with args' do
    tokens = [Soft::KeywordToken.new('meth'), [Soft::IdentifierToken.new('add'), Soft::IdentifierToken.new('num1'), Soft::IdentifierToken.new('num2')], Soft::KeywordToken.new('end')]
    statements = Soft::Parser.new.to_statements(tokens)

    statements.size.should == 2
    statements.first.class.should == Soft::MethodStatement
    statements[1].class.should == Soft::EndStatement
  end

  it 'integration spec' do
    source_code = <<-CODE
      meth cool(a,b)
        if a < b
          print a
          if a < b
            print b
          end
        end
      end
    CODE

    tokens = Soft::Scanner.tokenize source_code
    statements = Soft::Parser.new.to_statements(tokens)
    statements.map! {|s| s.inspect}
    
    statements.should == [Soft::MethodStatement, Soft::IfStatement, Soft::PrintStatement, Soft::IfStatement, Soft::PrintStatement, Soft::EndStatement, Soft::EndStatement, Soft::EndStatement]
  end
end
