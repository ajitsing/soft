require_relative './predicate_statement.rb'

class IfStatement < PredicateStatement
  def initialize(lhs, comparator, rhs)
    super(lhs, comparator, rhs)
  end
end
