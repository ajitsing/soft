module Soft
  class StateMachine
    def initialize
      @current_state = :not_started
    end

    def in_final_state?
      @current_state == :final
    end

    def running?
      @current_state == :running
    end

    def halted?
      @current_state == :halt
    end

    def not_started?
      @current_state == :not_started
    end

    def state
      @current_state
    end

    def reset_state
      @current_state = :not_started
    end
  end
end