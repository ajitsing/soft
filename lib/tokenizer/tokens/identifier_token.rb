module Soft
  class IdentifierToken < Token
    def inspect
      'ID:' + @tok
    end
  end
end