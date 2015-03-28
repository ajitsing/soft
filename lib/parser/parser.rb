Dir["./lib/tokenizer/*.rb"].each {|file| require file }
require 'pry'

class Parser
  def parse(tokens)
    super_block, i = Block.new, 0

    while i < tokens.size
      curr_tok = tokens[i]
      p curr_tok.class

      case curr_tok
        when KeywordToken
          if curr_tok.print?
            super_block.add_statement PrintStatement.new tokens[i+1].val
            i += 2
          elsif curr_tok.if?
            super_block.add_statement IfStatement.new(tokens[i+1], tokens[i+2], tokens[i+3])
            i += 4
          elsif curr_tok.while?
            super_block.add_statement WhileStatement.new(tokens[i+1], tokens[i+2], tokens[i+3])
            i += 4
          end
        when IdentifierToken
          if tokens[i+1].val == 'EQ'
            super_block.add_statement AssignmentStatement.new(curr_tok.val, tokens[i+2].val)
            i += 3
          end
        else
          p "other:#{curr_tok}"
          i += 1
      end
    end

    super_block
  end
end
