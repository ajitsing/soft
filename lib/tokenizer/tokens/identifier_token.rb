require_relative 'token'

class IdentifierToken < Token
  def inspect
    'ID:' + @tok
  end
end
