module Soft
  class IfStatement < PredicateStatement
    attr_accessor :block

    def initialize(lhs, comparator, rhs)
      super(lhs, comparator, rhs)
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
      p "#{spaces}IF_STATEMENT(#{@lhs}, #{@comparator}, #{@rhs})"
      @block.print(true)
    end
  end
end