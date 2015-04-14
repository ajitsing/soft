module Soft
  class PrintStatement < Statement
    attr_accessor :value

    def initialize(value)
      @value = value
    end

    def print(spaces)
      p "#{spaces}PRINT_STATEMENT(#{@value})"
    end
  end
end