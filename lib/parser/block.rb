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

  def print(with_spaces = false)
    @spaces ||= ""
    @spaces += "    " if with_spaces
    @statements.collect {|s| s.print(@spaces)}
  end
end
