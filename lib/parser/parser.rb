Dir["./lib/tokenizer/*.rb"].each {|file| require file }
require 'pry'

class Parser
  def parse(tokens)
    super_block, i = Block.new, 0

    add = lambda do |statement|
        if !super_block.statements.empty? and super_block.statements.last.has_block?
          super_block.statements.last.block.add_statement statement
        else
          super_block.add_statement statement
        end
    end

    skip_tokens = lambda { |increment_by| i += increment_by }

    while i < tokens.size
      curr_tok = tokens[i]

      case curr_tok
        when KeywordToken
          if curr_tok.print?
            add.call PrintStatement.new tokens[i+1].val
            skip_tokens.call(2)
          elsif curr_tok.if?
            add.call IfStatement.new(tokens[i+1].val, tokens[i+2].val, tokens[i+3].val)
            skip_tokens.call(4)
          elsif curr_tok.while?
            add.call WhileStatement.new(tokens[i+1].val, tokens[i+2].val, tokens[i+3].val)
            skip_tokens.call(4)
          else
            skip_tokens.call(1)
          end
        when IdentifierToken
          if tokens[i+1].val == 'EQ'
            add.call AssignmentStatement.new(curr_tok.val, tokens[i+2].val)
            skip_tokens.call(3)
          else
            skip_tokens.call(1)
          end
        else
          p "other:#{curr_tok}"
          skip_tokens.call(1)
      end
    end

    super_block
  end
end
