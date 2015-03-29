class Statement
  def initialize(tokens)
    @statement = tokens
  end

  def has_block?
    false
  end

  def inspect
    'STATEMENT'
  end
end
