# frozen_string_literal: true

require_relative 'grid_factory'

# Initializes the universe and delegates processing steps
class GameGenerator
  def initialize(input)
    @input = input
  end

  attr_accessor :input

  def call
    grid
  end

  private

  def grid
    GridFactory.new(input).call
  end
end
