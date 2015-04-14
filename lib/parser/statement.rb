module Soft
  class Statement
    def initialize(tokens)
      @statement = tokens
    end

    def has_block?
      false
    end

    def inspect
      self.class
    end
  end
end