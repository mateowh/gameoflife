require 'rspec'
require 'grid_iterator'
require 'cell'

describe 'GridIterator' do
  let(:cell_1_1) { build(:cell, :alive) }
  let(:cell_1_2) { build(:cell, :dead) }
  let(:cell_2_1) { build(:cell, :dead) }
  let(:cell_2_2) { build(:cell, :dead) }

  let(:grid) do
    [
      [cell_1_1, cell_1_2],
      [cell_2_1, cell_2_2]
    ]
  end

  subject { GridIterator.new(grid) }

  it 'is a GridIterator object' do
    expect(subject.is_a?(GridIterator)).to be true
  end

  describe 'call' do
    it 'returns a grid in the same format as the input' do
      expect(subject.call).to eq(grid)
    end

    context 'when cells have no live neighbours' do
      it 'kills these cells' do
        expect { subject.call }.to change { cell_1_1.state }.from(Cell::ALIVE).to(Cell::DEAD)
      end

      it 'does not change the other cells' do
        subject.call
        expect(cell_1_2.state).to eq(Cell::DEAD)
        expect(cell_2_1.state).to eq(Cell::DEAD)
        expect(cell_2_2.state).to eq(Cell::DEAD)
      end
    end

    context 'when cells have only one live neighbour' do
      let(:cell_1_2) { build(:cell, :alive) }
      it 'kills these cells' do
        expect { subject.call }
          .to change { cell_1_1.state }
          .from(Cell::ALIVE).to(Cell::DEAD)
          .and change { cell_1_2.state }
          .from(Cell::ALIVE).to(Cell::DEAD)
      end

      it 'does not change the other cells' do
        subject.call
        expect(cell_2_1.state).to eq(Cell::DEAD)
        expect(cell_2_2.state).to eq(Cell::DEAD)
      end
    end

    context 'when cells have 2 live neighbours' do
      let(:cell_1_2) { build(:cell, :alive) }
      let(:cell_2_1) { build(:cell, :alive) }
      it 'keeps these cells alive' do
        subject.call
        expect(cell_1_1.state).to eq(Cell::ALIVE)
        expect(cell_1_2.state).to eq(Cell::ALIVE)
        expect(cell_2_1.state).to eq(Cell::ALIVE)
        expect(cell_2_2.state).to eq(Cell::DEAD)
      end
    end
  end
end
