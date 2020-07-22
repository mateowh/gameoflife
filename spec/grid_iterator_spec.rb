require 'rspec'
require 'grid_iterator'
require 'cell'

describe 'GridIterator' do
  let(:cell_1_1) { build(:cell, :dead) }
  let(:cell_1_2) { build(:cell, :dead) }
  let(:cell_1_3) { build(:cell, :dead) }
  let(:cell_2_1) { build(:cell, :dead) }
  let(:cell_2_2) { build(:cell, :dead) }
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

    it 'returns all dead cells unchanged' do
      subject.call
      expect(grid.flatten.map(&:state).uniq).to eq([Cell::DEAD])
    end

    context 'when there is a live cell' do
      let(:cell_2_2) { build(:cell, :alive) }
      context 'and it has no live neighbours' do
        it 'kills this cell' do
          expect { subject.call }.to change { cell_2_2.state }.from(Cell::ALIVE).to(Cell::DEAD)
        end
      end

      context 'and it has only one live neighbour' do
        let(:cell_1_1) { build(:cell, :alive) }
        it 'kills this cell' do
          expect { subject.call }
            .to change { cell_1_1.state }
            .from(Cell::ALIVE).to(Cell::DEAD)
            .and change { cell_2_2.state }
            .from(Cell::ALIVE).to(Cell::DEAD)
        end
      end

      context 'and it has 2 live neighbours' do
        let(:cell_1_2) { build(:cell, :alive) }
        let(:cell_3_2) { build(:cell, :alive) }
        it 'keeps this cell alive' do
          expect { subject.call }.not_to change(cell_2_2, :state)
        end
      end

      context 'and it has 3 live neighbours' do
        let(:cell_1_2) { build(:cell, :alive) }
        let(:cell_1_1) { build(:cell, :alive) }
        let(:cell_3_3) { build(:cell, :alive) }
        it 'keeps this cell alive' do
          expect { subject.call }.not_to change(cell_2_2, :state)
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
      end
    end

    context 'when there is a deal cell' do
      it 'stays dead' do
        expect { subject.call }.not_to change(cell_2_2, :state)
      end

      context 'and it has at least 1 live neighbour' do
        let(:cell_1_1) { build(:cell, :alive) }
        it 'stays dead' do
          expect { subject.call }.not_to change(cell_2_2, :state)
        end

        context 'and exactly 3 in total' do
          let(:cell_1_2) { build(:cell, :alive) }
          let(:cell_1_3) { build(:cell, :alive) }
          it 'comes alive' do
            expect { subject.call }.to change { cell_2_2.state }.from(Cell::DEAD).to(Cell::ALIVE)
          end
        end

        context 'and more than 3' do
          let(:cell_1_2) { build(:cell, :alive) }
          let(:cell_1_3) { build(:cell, :alive) }
          let(:cell_2_1) { build(:cell, :alive) }
          it 'stays dead' do
            expect { subject.call }.not_to change(cell_2_2, :state)
          end
        end
      end
    end
  end
end
