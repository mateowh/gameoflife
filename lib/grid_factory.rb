# frozen_string_literal: true

# Creates a grid (2d array) from the user's input
class GridFactory
  def initialize(input)
    @input = input
  end

  attr_reader :input

  def call
    split_input
  end

  private

  def split_input
    input.split('/n').map { |a| a.split('') }
  end
end
