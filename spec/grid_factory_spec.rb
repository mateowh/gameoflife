# frozen_string_literal: true

require 'rspec'

describe 'GridFactory' do
  input = '.../nthis/nis/na/ntest'
  subject { GridFactory.new(input) }

  it 'is a GridFactory object' do
    expect(subject.is_a?(GridFactory)).to be true
  end

  describe 'call' do
    it 'returns input as an array of arrays split by new line' do
      expect(subject.call).to eq(
        [
          %w[. . .],
          %w[t h i s],
          %w[i s],
          %w[a],
          %w[t e s t]
        ]
      )
    end
  end
end
