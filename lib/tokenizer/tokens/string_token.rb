module Soft
  class StringToken < Token
    def inspect
      'STRING:' + @tok
    end
  end
end