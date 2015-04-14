module Soft
  class MethArgsMachine < StateMachine
    def initialize
      super
      @meth_args_exp = Regexp.new(/[a-zA-Z]+\((([a-zA-Z0-9]+[ ]*,)+[ ]*)+[a-zA-Z0-9]+\)/)
      @input = ""
    end

    def input(x)
      @input << x
      @current_state = :running
      self
    end

    def in_final_state?
      !@meth_args_exp.match(@input).nil?
    end

    def reset_state
      super
      @input = ""
    end

    def val
      split = @input.split('(')
      meth_name, args = split.first, split[1].chop
      tokens = args.split(',').map { |x| IdentifierToken.new(x.strip) }
      [IdentifierToken.new(meth_name)] + tokens
    end
  end
end