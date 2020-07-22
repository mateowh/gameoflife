require_relative 'cell'

# Creates a grid (2d array) from the user's input
class GridFactory
  PERMITTED_CHARACTERS = Cell::STATES

  def initialize(input)
    @input = input
  end

  attr_reader :input

  def call
    process_input
  end

  private

  def process_input
    rows = input.split("\n")
    rows.map! { |row| process_row(row) }.compact
  end

  def process_row(row)
    return if ignore?(row)

    row_array = row.split('')
    validate_user_input(row_array)
    row_array.map { |c| Cell.new(c) }
  end

  def ignore?(row)
    row.chars.first == '!'
  end

  def validate_user_input(row_array)
    extra_chars = row_array - PERMITTED_CHARACTERS
    return if extra_chars.empty?

    raise "Invalid input - only '.' or 'O' characters allowed"
  end
end
