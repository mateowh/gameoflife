require_relative 'grid_factory'
require_relative 'grid_iterator'
require_relative 'presenter'

# Initializes the universe and delegates processing steps
class GameGenerator
  def initialize(input)
    @input = input
  end

  attr_accessor :input

  def call
    new_grid = iterate_grid(grid)
    present_game_output(new_grid)
  end

  private

  def grid
    GridFactory.new(input).call
  end

  def iterate_grid(initial_grid)
    GridIterator.new(initial_grid).call
  end

  def present_game_output(game_grid)
    Presenter.new(game_grid).call
  end
end
