require_relative 'token'

class NewObjToken < Token
  def inspect
    'NewObj:' + @tok
  end
end
