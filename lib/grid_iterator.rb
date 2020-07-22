require 'byebug'
require_relative 'cell'

# Updates a grid of cells through one iteration
class GridIterator
  def initialize(initial_grid)
    @initial_grid = initial_grid
    @grid_width = initial_grid.first.length
    @grid_height = initial_grid.length
    @cells_to_kill = []
    @cells_to_revive = []
  end

  attr_reader :initial_grid, :grid_width, :grid_height, :cells_to_kill, :cells_to_revive

  def call
    new_grid = initial_grid.map.with_index do |arr, y_index|
      arr.map.with_index do |cell, x_index|
        assess_cell(cell, x_index, y_index)
      end
    end
    update_cells!
    new_grid
  end

  private

  def assess_cell(cell, x_position, y_position)
    neighbours = neighbours(cell, x_position, y_position)
    alive_neighbours = alive_neighbours(neighbours)

    cells_to_kill.push(cell) if should_kill?(cell, alive_neighbours)
    cells_to_revive.push(cell) if should_revive?(cell, alive_neighbours)

    cell
  end

  def update_cells!
    cells_to_kill.map(&:kill!)
    cells_to_revive.map(&:revive!)
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

  def should_kill?(cell, alive_neighbours)
    cell.alive? && (alive_neighbours < 2 || alive_neighbours > 3)
  end

  def should_revive?(cell, alive_neighbours)
    cell.dead? && alive_neighbours == 3
  end
end
