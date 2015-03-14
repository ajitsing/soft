require_relative './tokenizer/token_factory'

class Scanner
  def self.tokenize(source)
    tokens = []
    factory = TokenFactory.new

    source.each_char do |char|
      if (char.eql? ' ' or char.eql? "\n") and factory.any_machine_in_final_state?
        next_token = factory.get_token
        add_token_to(tokens, next_token)
        factory.reset_machines
      else
        factory.raw_data char
      end
    end

    p tokens
  end

  def self.add_token_to(tokens, next_token)
    if !tokens.empty? and tokens.last.expression? and next_token.expression?
      tokens[-1] = Token.new('EXP:' + tokens.last.val + next_token.val)
    else
      tokens.push next_token
    end
  end
end
