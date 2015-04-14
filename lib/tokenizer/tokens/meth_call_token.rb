module Soft
  class MethCallToken < Token
    def inspect
      'MethCall:' + @tok
    end
  end
end