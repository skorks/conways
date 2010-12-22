require 'conways/cell'

module Conways 
  class Grid
    class << self
      def from_input(bit_grid)
        cell_grid = []
        bit_grid.each do |row|
          current_row = []
          row.each do |column|
            current_row << Cell.new(column)
          end
          cell_grid << current_row
        end
        Grid.new(cell_grid)
      end
    end

    def initialize(cell_grid)
      @cell_grid = cell_grid
    end

    def find_cell_at(row, column)
      return nil if row < 0 || row > @cell_grid.size - 1
      return nil if column < 0 || column > @cell_grid[row].size - 1
      @cell_grid[row][column]
    end

    def find_neighbours_of_cell_at(row,column)
      neighbours = {}
      neighbours["N"] = find_cell_at(row-1, column)
      neighbours["NE"] = find_cell_at(row-1, column+1)
      neighbours["E"] = find_cell_at(row, column+1)
      neighbours["SE"] = find_cell_at(row+1, column+1)
      neighbours["S"] = find_cell_at(row+1, column)
      neighbours["SW"] = find_cell_at(row+1, column-1)
      neighbours["W"] = find_cell_at(row, column-1)
      neighbours["NW"] = find_cell_at(row-1, column-1)
      neighbours
    end

    def to_s
      grid_string = ""
      @cell_grid.each_with_index do |row, row_index|
        row_string = ""
        row.each_with_index do |cell, column_index|
          if cell.live?
            row_string += "X "
          else
            row_string += ". "
          end
        end
        grid_string += "#{row_string}\n"
      end
      grid_string
    end

    def tick
      calculate_next_generation_state
      next_generation
      remove_redundant_rows(@cell_grid)
      add_new_rows(@cell_grid)
      transposed_cell_grid = @cell_grid.transpose
      remove_redundant_rows(transposed_cell_grid)
      add_new_rows(transposed_cell_grid)
      @cell_grid = transposed_cell_grid.transpose
    end

    def remove_redundant_rows(cell_grid)
      candidate_row_indexes = []
      cell_grid.each_with_index do |row, row_index|
        if row.select{|cell| cell.live?}.size == 0
          candidate_row_indexes << row_index
        else
          candidate_row_indexes.pop
          break
        end
      end
      (cell_grid.size - 1).downto(0) do |row_index|
        row = cell_grid[row_index]
        if row.select{|cell| cell.live?}.size == 0
          candidate_row_indexes << row_index
        else
          candidate_row_indexes.pop
          break
        end
      end
      if candidate_row_indexes.size > 10
        candidate_row_indexes = candidate_row_indexes.select{|row_index|
          row_index >= 0}
          candidate_row_indexes.each_with_index {|row, index|
            cell_grid.delete_at(row - index)}
      end
    end

    def add_new_rows(cell_grid)
      #if a row has a live cell and doesn't have another row following it, we should add another row
      live_cells_in_last_row = cell_grid.last.select{|cell| cell.live?}
      cell_grid << create_row_of_dead_cells_from_template(cell_grid.last) if live_cells_in_last_row.size > 0
      live_cells_in_first_row = cell_grid.first.select{|cell| cell.live?}
      cell_grid.insert(0, create_row_of_dead_cells_from_template(cell_grid.first)) if live_cells_in_first_row.size > 0
    end

    def create_row_of_dead_cells_from_template(row_of_cells)
      new_row_of_cells = []
      row_of_cells.each do |cell|
        new_row_of_cells << Cell.new(0)
      end
      new_row_of_cells
    end

    def calculate_next_generation_state
      @cell_grid.each_with_index do |row, row_index|
        row.each_with_index do |cell, column_index|
          live_neighbours = live_neighbours_of_cell_at(row_index, column_index)
          if cell.live? && live_neighbours < 2
            cell.next_state = Cell::DEAD
          elsif cell.live? && live_neighbours > 1 && live_neighbours < 4
            cell.next_state = Cell::LIVE
          elsif cell.live? && live_neighbours > 3
            cell.next_state = Cell::DEAD
          elsif cell.dead? && live_neighbours == 3
            cell.next_state = Cell::LIVE
          else
            cell.next_state = cell.state
          end
        end
      end
    end

    def live_neighbours_of_cell_at(row, column)
      live_neighbours_count = find_neighbours_of_cell_at(row, column).values.compact.inject(0){|sum, element| sum + element.state}
      live_neighbours_count
    end

    def next_generation
      @cell_grid.each_with_index do |row, row_index|
        row.each_with_index do |cell, column_index|
          cell.move_to_next_state
        end
      end
    end
  end
end
