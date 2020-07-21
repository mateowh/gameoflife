# Formats the output of the game and presents to the user in standard output
class Presenter
  def initialize(grid)
    @grid = grid
  end

  attr_reader :grid

  def call
    print grid.map { |a| present_row(a).join('') }.join("\n")
  end

  def present_row(row)
    row.map(&:state)
  end
end
