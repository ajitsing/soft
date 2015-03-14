class Token
  def initialize(tok_string)
    @tok = tok_string
  end

  def print?
    @tok.upcase == "PRINT"
  end

  def string?
    @tok.start_with? "STRING:"
  end

  def variable?
    @tok.start_with? "VAR:"
  end

  def expression?
    @tok.start_with? "EXP:"
  end

  def number?
    @tok.start_with? "NUM:"
  end

  def string
    @tok[7..-1]
  end

  def expression
    @tok[4..-1]
  end

  def number
    @tok[4..-1].to_i
  end

  def var_name
    @tok[4..-1]
  end

  def val
    if expression?
      expression
    elsif string?
      string
    elsif number?
      number
    end
  end

  def raw
    @tok
  end

  def inspect
    @tok
  end
end
