require_relative 'token'

class StringToken < Token
  def inspect
    'STRING:' + @tok
  end
end
