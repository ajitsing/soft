require_relative './predicate_statement.rb'
require_relative './block.rb'

class WhileStatement < PredicateStatement
  attr_accessor :block

  def initialize(lhs, comparator, rhs)
    super(lhs, comparator, rhs)
    @block = Block.new
  end

  def has_block?
    true
  end

  def print
    p "WHILE_STATEMENT(#{@lhs}, #{@comparator}, #{@rhs})"
    @block.print
  end
end
