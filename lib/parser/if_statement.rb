require_relative './predicate_statement.rb'
require_relative './block.rb'

class IfStatement < PredicateStatement
  attr_accessor :block

  def initialize(lhs, comparator, rhs)
    super(lhs, comparator, rhs)
    @block = Block.new
  end

  def has_block?
    true
  end

  def print
    p "IF_STATEMENT(#{@lhs}, #{@comparator}, #{@rhs})"
    @block.print
  end
end
