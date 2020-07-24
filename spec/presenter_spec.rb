require 'presenter'

RSpec.describe Presenter do
  let(:cell) { instance_double(Cell) }
  before { allow(cell).to receive(:state) }
  let(:grid) do
    [
      [cell, cell],
      [cell, cell]
    ]
  end
  subject { Presenter.new(grid) }

  it 'is a Presenter object' do
    expect(subject.is_a?(Presenter)).to be true
  end

  describe 'call' do
    let(:dead_cell) { instance_double(Cell) }
    let(:live_cell) { instance_double(Cell) }

    before do
      allow(dead_cell).to receive(:state).and_return(Cell::DEAD)
      allow(live_cell).to receive(:state).and_return(Cell::ALIVE)
    end

    let(:grid) do
      [
        [dead_cell, dead_cell, live_cell, dead_cell],
        [dead_cell, live_cell, dead_cell, dead_cell],
        [dead_cell, dead_cell, live_cell, dead_cell]
      ]
    end

    it 'formats the grid and outputs it to standard output' do
      expect { subject.call }.to output("..O.\n.O..\n..O.").to_stdout
    end
  end
end
