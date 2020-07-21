require_relative 'grid_factory'
require_relative 'presenter'

# Initializes the universe and delegates processing steps
class GameGenerator
  def initialize(input)
    @input = input
  end

  attr_accessor :input

  def call
    present_game_output
  end

  private

  def grid
    GridFactory.new(input).call
  end

  def present_game_output
    Presenter.new(grid).call
  end
end
