module Soft
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

      tokens
    end

    def self.add_token_to(tokens, next_token)
      if !tokens.empty? and tokens.last.is_a? ExpressionToken and next_token.is_a? ExpressionToken
        tokens[-1] = ExpressionToken.new(tokens.last.val + next_token.val)
      else
        tokens << next_token
      end
    end
  end
end