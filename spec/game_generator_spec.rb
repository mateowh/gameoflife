require 'rspec'
require 'game_generator'
require 'grid_factory'
require 'presenter'

describe 'GameGenerator' do
  let(:input) { 'test' }
  before(:each) do
    allow($stdin).to receive(:gets).and_return(input)
  end

  subject { GameGenerator.new($stdin.gets) }

  it 'is a GameGenerator object' do
    expect(subject.is_a?(GameGenerator)).to be true
  end

  describe 'call' do
    it 'returns input as a 2d array of characters' do
      expect { subject.call }.to output('test').to_stdout
    end

    context 'when multiple lines of input' do
      let(:input) { "I\nam\na\ntest" }
      it 'splits each line into separate array' do
        expect { subject.call }.to output("I\nam\na\ntest").to_stdout
      end
    end

    context 'it delegates to other classes' do
      let(:input) { "I\nam\na\ntest" }
      let(:grid) { [%w[I], %w[am], %w[a], %w[t e s t]] }

      it 'calls GridFactory' do
        expect(GridFactory).to receive(:new).with(input).and_return(double(call: grid))

        subject.call
      end

      it 'calls Presenter'
    end
  end
end
