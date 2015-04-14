module Soft
  class EndStatement < Statement
    def initialize;
    end

    def print(spaces)
      p "#{spaces}END_STATEMENT"
    end
  end
end