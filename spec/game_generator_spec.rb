require 'rspec'
require 'game_generator'
require 'grid_factory'
require 'presenter'

describe 'GameGenerator' do
  let(:input) { "...\n..O\n.O." }
  before(:each) do
    allow($stdin).to receive(:gets).and_return(input)
  end

  subject { GameGenerator.new($stdin.gets) }

  it 'is a GameGenerator object' do
    expect(subject.is_a?(GameGenerator)).to be true
  end

  describe 'call' do
    let(:game_output) { "...\n...\n..." }
    it 'returns input as a 2d array of characters' do
      expect { subject.call }.to output(game_output).to_stdout
    end

    context 'it delegates to other classes' do
      let(:cell) { instance_double(Cell) }
      before { allow(cell).to receive(:state) }
      before { allow(cell).to receive(:kill!) }
      before { allow(cell).to receive(:revive!) }
      before { allow(cell).to receive(:alive?) }
      before { allow(cell).to receive(:dead?) }
      let(:grid) { [[cell, cell, cell], [cell, cell, cell], [cell, cell, cell]] }

      it 'calls GridFactory' do
        expect(GridFactory).to receive(:new).with(input).and_return(double(call: grid))

        subject.call
      end

      it 'calls Presenter' do
        expect(Presenter).to receive(:new).with(Array).and_return(double(call: String))

        subject.call
      end
    end

    context 'when the input has invalid characters' do
      let(:input) { "this\nfails" }
      let(:message) { "Invalid input - only '.' or 'O' characters allowed" }
      it 'exits and alerts the user' do
        expect { subject.call }.to raise_error(an_instance_of(RuntimeError).and(having_attributes(message: message)))
      end
    end
  end
end
