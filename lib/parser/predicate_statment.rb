require_relative './statment.rb'

class PredicateStatment < Statment
  def initialize(tokens)
    super(tokens)
  end

  def predicate
    @statment[1..-1]
  end
end
