require_relative './tokenizer/token_factory'

class Scanner
  def self.tokenize(source)
    tokens = []
    factory = TokenFactory.new

    source.each_char do |char|
      if (char.eql? ' ' or char.eql? "\n") and factory.any_machine_in_final_state?
        add_token_to(tokens, factory.get_token)
        factory.reset_machines
      elsif char.eql? '(' and factory.any_machine_in_final_state?
        add_token_to(tokens, factory.get_token)
        factory.raw_data char
      else
        factory.raw_data char
      end
    end

    tokens
  end

  def self.add_token_to(tokens, next_token)
    if !tokens.empty? and tokens.last.is_a? ExpressionToken and next_token.is_a? ExpressionToken
      tokens[-1] = ExpressionToken.new(tokens.last.val + next_token.val)
    else
      if next_token.is_a? Array
        tokens += next_token
      else
        tokens.push next_token
      end
    end
  end
end
