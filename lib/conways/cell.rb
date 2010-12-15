class Cell
 class << self
   def live
     1
   end

   def dead
     0
   end
 end

 attr_accessor :neighbours, :state, :next_state, :previous_state
 def initialize(state)
   @state = state
   @next_state = nil
 end

 def live?
   @state == Cell.live
 end

 def dead?
   @state == Cell.dead
 end

 def update_to_next_generation_state
   @state = @next_state
   @next_state = nil
 end
end
