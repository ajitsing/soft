require_relative 'token'

class KeywordToken < Token
  def inspect
    'KEY:' + @tok
  end
end
