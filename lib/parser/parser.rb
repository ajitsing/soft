Dir["./lib/tokenizer/*.rb"].each {|file| require file }

class Parser
  def to_statements(tokens)
    i = 0
    statements = []

    skip_tokens = lambda { |increment_by| i += increment_by }

    while i < tokens.size
      curr_tok = tokens[i]

      case curr_tok
        when KeywordToken
          if curr_tok.print?
            statements << PrintStatement.new(tokens[i+1].val)
            skip_tokens.call(2)
          elsif curr_tok.if?
            statements << IfStatement.new(tokens[i+1].val, tokens[i+2].val, tokens[i+3].val)
            skip_tokens.call(4)
          elsif curr_tok.while?
            statements << WhileStatement.new(tokens[i+1].val, tokens[i+2].val, tokens[i+3].val)
            skip_tokens.call(4)
          elsif curr_tok.end?
            statements << EndStatement.new
            skip_tokens.call(1)
          elsif curr_tok.meth?
            meth_name = tokens[i+1].is_a?(Array) ? tokens[i+1].first : tokens[i+1]
            args = tokens[i+1].is_a?(Array) ? tokens[i+1][1..-1] : []
            statements << MethodStatement.new(meth_name, args)
            skip_tokens.call(2)
          else
            skip_tokens.call(1)
          end
        when IdentifierToken
          if tokens[i+1].val == 'EQ'
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
