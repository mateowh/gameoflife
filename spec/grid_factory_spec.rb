require 'rspec'
require 'grid_factory'

describe 'GridFactory' do
  let(:input) { "...\n..O\n.O." }
  let(:dead_cell) { have_attributes(class: Cell, state: '.') }
  let(:live_cell) { have_attributes(class: Cell, state: 'O') }

  subject { GridFactory.new(input) }

  it 'is a GridFactory object' do
    expect(subject.is_a?(GridFactory)).to be true
  end

  describe 'call' do
    it 'returns input as an array of arrays split by new line' do
      expect(subject.call).to match_array(
        [
          [dead_cell, dead_cell, dead_cell],
          [dead_cell, dead_cell, live_cell],
          [dead_cell, live_cell, dead_cell]
        ]
      )
    end

    context 'when the input is marked to be ignored (starting with a !)' do
      let(:input) { "!testing\n...\n.O." }
      it 'drops these rows and returns the rest' do
        expect(subject.call).to match_array(
          [
            [dead_cell, dead_cell, dead_cell],
            [dead_cell, live_cell, dead_cell]
          ]
        )
      end
    end

    context 'when the input has invalid characters' do
      let(:input) { "this\nshould\nfail" }
      let(:message) { "Invalid input - only '.' or 'O' characters allowed" }
      it 'exits and alerts the user' do
        expect { subject.call }.to raise_error(an_instance_of(RuntimeError).and(having_attributes(message: message)))
      end
    end
  end
end
