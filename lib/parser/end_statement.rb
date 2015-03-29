require_relative './statement.rb'

class EndStatement < Statement
  def initialize; end

  def print(spaces)
    p "#{spaces}END_STATEMENT"
  end
end
