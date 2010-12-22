module Conways 
  class Cell
    LIVE = 1
    DEAD = 0
    class << self
      def live_one
        Cell.new Cell::LIVE
      end

      def dead_one
        Cell.new Cell::DEAD
      end
    end

    attr_accessor :state, :next_state
    def initialize(state)
      raise "Cell must be live or dead" unless state == Cell::LIVE || state == Cell::DEAD
      @state = state
      @next_state = nil
    end

    def live?
      @state == Cell::LIVE
    end

    def dead?
      @state == Cell::DEAD
    end

    def move_to_next_state
      @state = @next_state
      @next_state = nil
    end
  end
end
