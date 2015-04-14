module Soft
  class Token
    def initialize(tok_string)
      @tok = tok_string
    end

    def val
      @tok
    end

    def inspect
      @tok
    end
  end
end