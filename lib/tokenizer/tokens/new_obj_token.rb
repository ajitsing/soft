module Soft
  class NewObjToken < Token
    def inspect
      'NewObj:' + @tok
    end
  end
end