class PrintStatement
  attr_accessor :value
  def initialize(value)
    @value = value
  end

  def print
    p "PRINT_STATEMENT(#{@value})"
  end
end
