require 'grid_iterator'

RSpec.describe GridIterator do
  let(:cell_1_1) { build(:cell, :dead) }
  let(:cell_1_2) { build(:cell, :dead) }
  let(:cell_1_3) { build(:cell, :dead) }
  let(:cell_2_1) { build(:cell, :dead) }
  let(:cell_2_2) { build(:cell, :dead) }
  let(:cell_2_3) { build(:cell, :dead) }
  let(:cell_3_1) { build(:cell, :dead) }
  let(:cell_3_2) { build(:cell, :dead) }
  let(:cell_3_3) { build(:cell, :dead) }

  let(:alive) { Cell::ALIVE }
  let(:dead) { Cell::DEAD }

  let(:grid) do
    [
      [cell_1_1, cell_1_2, cell_1_3],
      [cell_2_1, cell_2_2, cell_2_3],
      [cell_3_1, cell_3_2, cell_3_3]
    ]
  end

  def grid_state(grid)
    grid.map { |row| row.map(&:state) }
  end

  subject { GridIterator.new(grid) }

  describe 'call' do
    it 'returns a grid in the same format as the input' do
      expect(subject.call).to be_an_instance_of(Array)
    end

    it 'returns all dead cells unchanged' do
      subject.call
      expect(grid_state(grid)).to eq(
        [
          [dead, dead, dead],
          [dead, dead, dead],
          [dead, dead, dead]
        ]
      )
    end

    context 'when there is a live cell' do
      let(:cell_2_2) { build(:cell, :alive) }
      context 'and it has no live neighbours' do
        it 'kills this cell' do
          expect { subject.call }.to change { cell_2_2.state }.from(alive).to(dead)
        end

        it 'returns all cells as dead' do
          subject.call
          expect(grid_state(grid)).to eq(
            [
              [dead, dead, dead],
              [dead, dead, dead],
              [dead, dead, dead]
            ]
          )
        end
      end

      context 'and it has only one live neighbour' do
        let(:cell_1_1) { build(:cell, :alive) }
        it 'kills both these cells' do
          expect { subject.call }
            .to change { cell_1_1.state }
            .from(alive).to(dead)
            .and change { cell_2_2.state }
            .from(alive).to(dead)
        end

        it 'returns all cells as dead' do
          subject.call
          expect(grid_state(grid)).to eq(
            [
              [dead, dead, dead],
              [dead, dead, dead],
              [dead, dead, dead]
            ]
          )
        end
      end

      context 'and it has 2 live neighbours' do
        let(:cell_1_1) { build(:cell, :alive) }
        let(:cell_3_3) { build(:cell, :alive) }
        it 'keeps this cell alive' do
          expect { subject.call }.not_to change(cell_2_2, :state)
        end

        it 'kills other cells with fewer than 2 neighbours' do
          subject.call
          expect(grid_state(grid)).to eq(
            [
              [dead, dead, dead],
              [dead, alive, dead],
              [dead, dead, dead]
            ]
          )
        end
      end

      context 'and it has 3 live neighbours' do
        let(:cell_1_1) { build(:cell, :alive) }
        let(:cell_1_2) { build(:cell, :alive) }
        let(:cell_3_1) { build(:cell, :alive) }
        it 'keeps this cell alive' do
          expect { subject.call }.not_to change(cell_2_2, :state)
        end

        it 'iterates the whole of the grid' do
          subject.call
          expect(grid_state(grid)).to eq(
            [
              [alive, alive, dead],
              [dead, alive, dead],
              [dead, dead, dead]
            ]
          )
        end
      end

      context 'when a cell has more than 3 live neighbours' do
        let(:cell_1_1) { build(:cell, :alive) }
        let(:cell_1_2) { build(:cell, :alive) }
        let(:cell_1_3) { build(:cell, :alive) }
        let(:cell_3_2) { build(:cell, :alive) }
        it 'kills this cell' do
          expect { subject.call }.to change { cell_2_2.state }.from(alive).to(dead)
        end

        it 'iterates the whole of the grid' do
          subject.call
          expect(grid_state(grid)).to eq(
            [
              [alive, alive, alive],
              [dead, dead, dead],
              [dead, dead, dead]
            ]
          )
        end
      end
    end

    context 'when a deal cell has at least 1 live neighbour' do
      let(:cell_1_1) { build(:cell, :alive) }
      it 'stays dead' do
        expect { subject.call }.not_to change(cell_2_2, :state)
      end

      it 'iterates the whole of the grid' do
        subject.call
        expect(grid_state(grid)).to eq(
          [
            [dead, dead, dead],
            [dead, dead, dead],
            [dead, dead, dead]
          ]
        )
      end

      context 'and exactly 3 in total' do
        let(:cell_1_3) { build(:cell, :alive) }
        let(:cell_3_2) { build(:cell, :alive) }
        it 'comes alive' do
          expect { subject.call }.to change { cell_2_2.state }.from(dead).to(alive)
        end

        it 'leaves the rest of the grid dead' do
          subject.call
          expect(grid_state(grid)).to eq(
            [
              [dead, dead, dead],
              [dead, alive, dead],
              [dead, dead, dead]
            ]
          )
        end
      end

      context 'and more than 3' do
        let(:cell_1_3) { build(:cell, :alive) }
        let(:cell_2_3) { build(:cell, :alive) }
        let(:cell_3_2) { build(:cell, :alive) }
        it 'stays dead' do
          expect { subject.call }.not_to change(cell_2_2, :state)
        end

        it 'iterates the rest of the grid' do
          subject.call
          expect(grid_state(grid)).to eq(
            [
              [dead, alive, dead],
              [dead, dead, alive],
              [dead, dead, dead]
            ]
          )
        end
      end
    end
  end
end
