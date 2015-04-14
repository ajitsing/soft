module Soft
  class ExpressionToken < Token
    def inspect
      'EXP:' + @tok
    end
  end
end