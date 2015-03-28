class Block
  attr_accessor :statements

  def initialize(statements = [])
    @statements = statements
  end

  def add_statement(statement)
    @statements << statement
  end
end
