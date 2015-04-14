module Soft
  class KeywordToken < Token
    def inspect
      'KEY:' + @tok
    end

    def method_missing(name)
      @tok == name.to_s.chop
    end
  end
end