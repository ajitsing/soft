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

  it 'should tokenize a if condition' do
    source_code = <<-CODE
      if 10 > 5
        print "10 is greater than 5"
      end
    CODE

    tokens = Scanner.tokenize source_code
    tokens.map! { |t| t.inspect }

    tokens.should == ['KEY:if', 'EXP:10', 'GT', 'EXP:5', 'KEY:print', 'STRING:10 is greater than 5', 'KEY:end']
  end

  it 'should tokenize a if-else condition' do
    source_code = <<-CODE
      if 10 > 5
        print "10 is greater than 5"
      else
        print "5 is greater than 10"
      end
    CODE

    tokens = Scanner.tokenize source_code
    tokens.map! { |t| t.inspect }

    tokens.should == ['KEY:if', 'EXP:10', 'GT', 'EXP:5', 'KEY:print', 'STRING:10 is greater than 5', 'KEY:else', 'KEY:print', 'STRING:5 is greater than 10', 'KEY:end']
  end

  it 'should tokenize a while loop' do
    source_code = <<-CODE
      i = 10
      while i > 0
        print i
        i = i - 1
      end
    CODE

    tokens = Scanner.tokenize source_code
    tokens.map! { |t| t.inspect }

    tokens.should == ['ID:i', 'EQ', 'EXP:10', 'KEY:while', 'ID:i', 'GT', 'EXP:0', 'KEY:print', 'ID:i', 'ID:i', 'EQ', 'ID:i', 'EXP:-1', 'KEY:end']
  end

  it 'should tokenize everything' do
    source_code = <<-CODE
      class HelloWorld
        meth some_method_name
          var_name = "Ajit Singh"
          some_ex = 10 + 20 * 30
        end
      end
    CODE

    tokens = Scanner.tokenize source_code
    tokens.map! { |t| t.inspect }

    tokens.should == ['KEY:class', 'ID:HelloWorld',
                         'KEY:meth', 'ID:some_method_name',
                             'ID:var_name', 'EQ', 'STRING:Ajit Singh',
                             'ID:some_ex', 'EQ', 'EXP:10+20*30',
                          'KEY:end',
                     'KEY:end']
  end
end
