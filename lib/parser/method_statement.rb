module Soft
  class MethodStatement < Statement
    attr_accessor :block

    def initialize(name, args)
      @name = name
      @args = args
      @block = Block.new
      @block_closed = false
    end

    def has_block?
      true
    end

    def add_statement(statement)
      @block.add_statement statement
    end

    def end_block
      @block_closed = true
    end

    def block_closed?
      @block_closed
    end

    def print(spaces)
      p "#{spaces}METH (#{@name},(#{@args})"
      @block.print(true)
    end
  end
end