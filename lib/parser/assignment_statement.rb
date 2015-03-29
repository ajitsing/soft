require_relative './statement.rb'

class AssignmentStatement < Statement
  def initialize(identifier, value)
    @identifier = identifier
    @value = value
  end

  def print(spaces)
    p "#{spaces}ASSIGNMENT_STATMENT(#{@identifier}, #{@value})"
  end
end
