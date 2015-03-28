require_relative './statement.rb'

class AssignmentStatement < Statement
  def initialize(identifier, value)
    @identifier = identifier
    @value = value
  end
end
