require 'byebug'
require_relative 'cell'

class GridIterator
  def initialize(initial_grid)
    @initial_grid = initial_grid
    @grid_width = initial_grid.first.length
    @grid_height = initial_grid.length
  end

  attr_reader :initial_grid, :grid_width, :grid_height

  def call
    initial_grid.map.with_index do |arr, y_index|
      arr.map.with_index do |cell, x_index|
        update_cell(cell, x_index, y_index)
      end
    end
  end

  private

  def update_cell(cell, x_position, y_position)
    neighbours = neighbours(cell, x_position, y_position)
    cell.kill if cell.alive? && alive_neighbours(neighbours) < 2
    cell.kill if cell.alive? && alive_neighbours(neighbours) > 3

    cell
  end

  def neighbours(cell, x_position, y_position)
    coords = neighbour_coordinates(x_position, y_position)
    cell_neighbours = []
    initial_grid[coords[:y]].each { |row| cell_neighbours << row[coords[:x]] }
    cell_neighbours.flatten - [cell]
  end

  def alive_neighbours(cells)
    cells.filter(&:alive?).length
  end

  def neighbour_coordinates(x_position, y_position)
    {
      x: [x_position - 1, 0].max..[x_position + 1, grid_width].min,
      y: [y_position - 1, 0].max..[y_position + 1, grid_height].min
    }
  end
end
