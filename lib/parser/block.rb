class Block
  attr_accessor :statements

  def initialize(statements = [])
    @statements = statements
  end

  def add_statement(statement)
    @statements << statement
  end

  def has_block?
    true
  end

  def print
    @statements.collect {|s| s.print}
  end
end
