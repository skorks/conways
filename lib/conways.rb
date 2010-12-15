require 'conways/grid'

module Conways 
  class Life 
    def initialize(input)
      @input = input
      @exit = false
      trap("SIGINT") do
        @exit = true
      end
    end

    def live
      grid = CellGrid.build_from(@input)
      loop do
        puts grid.to_s
        puts
        grid.tick
        sleep(1)
        exit if @exit
      end
      puts grid.to_s
      puts
    end
  end
end 

#some possible inputs
#[[0,0,0,0,0], [0,1,1,1,0], [0,0,0,0,0]]
#[[0,0,0,0,0,0], [0,0,1,1,1,0], [0,1,1,1,0,0], [0,0,0,0,0,0]]
#[[0,0,0,0,0], [0,0,1,0,0], [0,0,0,1,0], [0,1,1,1,0], [0,0,0,0,0]]
#[[0,0,0,0,0,0,0], [0,1,0,0,1,0,0],[0,0,0,0,0,1,0],[0,1,0,0,0,1,0],[0,0,1,1,1,1,0],[0,0,0,0,0,0,0]]
#[[0,0,0,0,0,0,0,0,0], [0,0,1,0,0,0,0,0,0],[0,0,0,0,1,0,0,0,0],[0,1,1,0,0,1,1,1,0],[0,0,0,0,0,0,0,0,0]] #acorn
