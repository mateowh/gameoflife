require 'rspec'
require 'presenter'

describe 'Presenter' do
  let(:grid) do
    [
      %w[. . . O .],
      %w[. O . . .],
      %w[. . O . .]
    ]
  end
  subject { Presenter.new(grid) }

  it 'is a Presenter object' do
    expect(subject.is_a?(Presenter)).to be true
  end

  describe 'call' do
    it 'formats the grid and outputs it to standard output' do
      expect { subject.call }.to output("...O.\n.O...\n..O..").to_stdout
    end
  end
end
