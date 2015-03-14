require 'spec_helper'
require './lib/scanner.rb'

describe :Scanner do
  it 'should tokenize a class declaration' do
    source_code = <<-CODE
      class HelloWorld
      end
    CODE

    tokens = Scanner.tokenize source_code
    tokens.map! { |t| t.inspect }

    tokens.should == ['KEY:class', 'ID:HelloWorld', 'KEY:end']
  end

  it 'should tokenize a method declaration' do
    source_code = <<-CODE
      meth some_name
      end
    CODE

    tokens = Scanner.tokenize source_code
    tokens.map! { |t| t.inspect }

    tokens.should == ['KEY:meth', 'ID:some_name', 'KEY:end']
  end

  it 'should tokenize a variable declaration' do
    source_code = <<-CODE
      some_var = "Ajit"
    CODE

    tokens = Scanner.tokenize source_code
    tokens.map! { |t| t.inspect }

    tokens.should == ['ID:some_var', 'EQ', 'STRING:Ajit']
  end

  it 'should tokenize everything' do
    source_code = <<-CODE
      class HelloWorld
        meth some_name
          some_var = "Ajit Singh"
          some_ex = 10+20*30
        end
      end
    CODE

    tokens = Scanner.tokenize source_code
    tokens.map! { |t| t.inspect }

    tokens.should == ['KEY:class', 'ID:HelloWorld',
                         'KEY:meth', 'ID:some_name',
                             'ID:some_var', 'EQ', 'STRING:Ajit Singh',
                             'ID:some_ex', 'EQ', 'EXP:10+20*30',
                          'KEY:end',
                     'KEY:end']
  end
end