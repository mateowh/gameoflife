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
    # TODO: Ruby 2.7 has filter_map method, upgrade for this
    input.split('/n').map { |a| a.split('') unless comment?(a) }.compact
  end

  def comment?(row)
    row.chars.first == '!'
  end
end
