# A simple class to represent each cell in the grid and store it's state
class Cell
  STATES = [
    ALIVE = 'O'.freeze,
    DEAD = '.'.freeze
  ].freeze

  def initialize(initial_state)
    @state = initial_state
  end

  attr_reader :state
end
