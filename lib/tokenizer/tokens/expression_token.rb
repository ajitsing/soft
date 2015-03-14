require_relative 'token'

class ExpressionToken < Token
  def inspect
    'EXP:' + @tok
  end
end
