module Soft
  class PredicateStatement < Statement
    def initialize(lhs, comparator, rhs)
      @lhs = lhs
      @comparator = comparator
      @rhs = rhs
    end

    def predicate
      [@lhs, @comparator, @rhs]
    end
  end
end