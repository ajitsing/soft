require_relative 'token'

class MethCallToken < Token
  def inspect
    'MethCall:' + @tok
  end
end
