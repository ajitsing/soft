require_relative './predicate_statement.rb'

class WhileStatement < PredicateStatement
  def initialize(lhs, comparator, rhs)
    super(lhs, comparator, rhs)
  end
end
