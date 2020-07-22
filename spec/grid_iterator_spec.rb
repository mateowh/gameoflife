require 'rspec'
require 'grid_iterator'
require 'cell'

describe 'GridIterator' do
  let(:cell_1_1) { build(:cell, :dead) }
  let(:cell_1_2) { build(:cell, :dead) }
  let(:cell_1_3) { build(:cell, :dead) }
  let(:cell_2_1) { build(:cell, :dead) }
  let(:cell_2_2) { build(:cell, :alive) }
  let(:cell_2_3) { build(:cell, :dead) }
  let(:cell_3_1) { build(:cell, :dead) }
  let(:cell_3_2) { build(:cell, :dead) }
  let(:cell_3_3) { build(:cell, :dead) }

  let(:grid) do
    [
      [cell_1_1, cell_1_2, cell_1_3],
      [cell_2_1, cell_2_2, cell_2_3],
      [cell_3_1, cell_3_2, cell_3_3]
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
        expect { subject.call }.to change { cell_2_2.state }.from(Cell::ALIVE).to(Cell::DEAD)
      end

      it 'does not change the other cells' do
        dead_cells = grid.flatten - [cell_2_2]
        subject.call
        expect(dead_cells.map(&:state).uniq).to eq([Cell::DEAD])
      end
    end

    context 'when cells have only one live neighbour' do
      let(:cell_1_1) { build(:cell, :alive) }
      it 'kills these cells' do
        expect { subject.call }
          .to change { cell_1_1.state }
          .from(Cell::ALIVE).to(Cell::DEAD)
      end

      it 'does not change the other cells' do
        dead_cells = grid.flatten - [cell_2_2, cell_1_1]
        subject.call
        expect(dead_cells.map(&:state).uniq).to eq([Cell::DEAD])
      end
    end

    context 'when cells have 2 live neighbours' do
      let(:cell_1_2) { build(:cell, :alive) }
      let(:cell_2_1) { build(:cell, :alive) }
      it 'keeps these cells alive' do
        subject.call
        live_cells = [cell_1_2, cell_2_1, cell_2_2]
        expect(live_cells.map(&:state).uniq).to eq([Cell::ALIVE])
        dead_cells = grid.flatten - live_cells
        expect(dead_cells.map(&:state).uniq).to eq([Cell::DEAD])
      end
    end

    context 'when cells have 3 live neighbours' do
      let(:cell_1_1) { build(:cell, :alive) }
      let(:cell_1_2) { build(:cell, :alive) }
      let(:cell_2_1) { build(:cell, :alive) }
      it 'keeps these cells alive' do
        subject.call
        live_cells = [cell_1_1, cell_1_2, cell_2_1, cell_2_2]
        expect(live_cells.map(&:state).uniq).to eq([Cell::ALIVE])
        dead_cells = grid.flatten - live_cells
        expect(dead_cells.map(&:state).uniq).to eq([Cell::DEAD])
      end
    end

    context 'when a cell has more than 3 live neighbours' do
      let(:cell_1_2) { build(:cell, :alive) }
      let(:cell_2_1) { build(:cell, :alive) }
      let(:cell_2_3) { build(:cell, :alive) }
      let(:cell_3_2) { build(:cell, :alive) }
      it 'kills this cell' do
        expect { subject.call }.to change { cell_2_2.state }.from(Cell::ALIVE).to(Cell::DEAD)
      end

      it 'leaves other cells unchanges' do
        subject.call
        alive_cells = [cell_1_2, cell_2_1, cell_2_3, cell_3_2]
        expect(alive_cells.map(&:state).uniq).to eq([Cell::ALIVE])
      end
    end
  end
end
