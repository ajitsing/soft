module Soft
  class Parser
    def validate_token(curr_tok, *tokens)
      tokens.each do |tok|
        begin
          tok.val
        rescue => e
          raise ParseException, "error while parsing token - #{curr_tok.val}"
        end
      end
    end

    def to_statements(tokens)
      i = 0
      statements = []

      skip_tokens = lambda { |increment_by| i += increment_by }

      while i < tokens.size
        curr_tok = tokens[i]

        case curr_tok
          when KeywordToken
            if curr_tok.print?
              validate_token curr_tok, tokens[i+1]
              statements << PrintStatement.new(tokens[i+1].val)
              skip_tokens.call(2)
            elsif curr_tok.if?
              validate_token curr_tok, tokens[i+1], tokens[i+2], tokens[i+3]
              statements << IfStatement.new(tokens[i+1].val, tokens[i+2].val, tokens[i+3].val)
              skip_tokens.call(4)
            elsif curr_tok.while?
              validate_token curr_tok, tokens[i+1], tokens[i+2], tokens[i+3]
              statements << WhileStatement.new(tokens[i+1].val, tokens[i+2].val, tokens[i+3].val)
              skip_tokens.call(4)
            elsif curr_tok.end?
              statements << EndStatement.new
              skip_tokens.call(1)
            elsif curr_tok.meth?
              if tokens[i+1].is_a?(Array)
                validate_token(curr_tok, tokens[i+1].first)
                meth_name = tokens[i+1].first
                args = tokens[i+1][1..-1]
              else
                validate_token(curr_tok, tokens[i+1])
                meth_name = tokens[i+1]
                args = []
              end
              statements << MethodStatement.new(meth_name, args)
              skip_tokens.call(2)
            else
              skip_tokens.call(1)
            end
          when IdentifierToken
            validate_token curr_tok, tokens[i+1]
            if tokens[i+1].val == 'EQ'
              validate_token curr_tok, tokens[i+2]
              statements << AssignmentStatement.new(curr_tok.val, tokens[i+2].val)
              skip_tokens.call(3)
            else
              skip_tokens.call(1)
            end
          else
            p "other:#{curr_tok}"
            skip_tokens.call(1)
        end
      end

      statements
    end
  end
end