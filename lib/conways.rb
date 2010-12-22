require 'conways/cell'
require 'conways/grid'

module Conways 
  class Life 
#some possible inputs
#[[0,0,0,0,0,0], [0,0,1,1,1,0], [0,1,1,1,0,0], [0,0,0,0,0,0]]
#[[0,0,0,0,0], [0,0,1,0,0], [0,0,0,1,0], [0,1,1,1,0], [0,0,0,0,0]]
#[[0,0,0,0,0,0,0], [0,1,0,0,1,0,0],[0,0,0,0,0,1,0],[0,1,0,0,0,1,0],[0,0,1,1,1,1,0],[0,0,0,0,0,0,0]]
    CROSS = [[0,0,0,0,0], [0,1,1,1,0], [0,0,0,0,0]]
    ACORN = [[0,0,0,0,0,0,0,0,0], [0,0,1,0,0,0,0,0,0],[0,0,0,0,1,0,0,0,0],[0,1,1,0,0,1,1,1,0],[0,0,0,0,0,0,0,0,0]]

    def initialize(input)
      input = input.gsub(/\s+/,"")
      begin
        @input = (input.class == String ? eval(input) : input)
      rescue StandardError => e
        raise "Your input was invalid somehow: #{e}"
      rescue SyntaxError => e
        raise "Your input didn't have correct syntax: #{e}"
      end
      raise "Input must be a two dimensional array" unless two_dimensional? @input
      raise "Input must only contain 0 or 1 as values" unless cell_values_correct? @input
      raise "Input rows must all be of the same size" unless even_rows? @input

      @exit = false
      trap("SIGINT") do
        @exit = true
      end
    end

    def two_dimensional?(input)
      input.each do |row|
        return false unless row.class == Array
      end
      true
    end

    def cell_values_correct?(input)
      input.each do |row|
        row.each do |cell|
          return false unless Conways::Cell::LIVE || Conways::Cell::DEAD
        end
      end
      true
    end

    def even_rows?(input)
      current_row_size = nil
      input.each do |row|
        return false if current_row_size && current_row_size != row.size
        current_row_size = row.size
      end
      true
    end

    #def live
      #grid = InputToGrid.convert @input
      #loop do
        #@output_writer.write grid
        #grid.tick
        #sleep(1)
        #exit if @exit
      #end
      #@output_writer.write grid
    #end

    def live
      grid = Grid.from_input @input
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

