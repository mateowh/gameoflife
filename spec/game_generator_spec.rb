# frozen_string_literal: false

require 'rspec'
require 'game_generator'

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
      expect(subject.call).to eq([%w[t e s t]])
    end

    context 'when multiple lines of input' do
      let(:input) { 'I/nam/na/ntest' }
      it 'splits each line into separate array' do
        expect(subject.call).to eq([%w[I], %w[a m], %w[a], %w[t e s t]])
      end
    end
  end
end
