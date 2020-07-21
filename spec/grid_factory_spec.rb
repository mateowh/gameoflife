require 'rspec'

describe 'GridFactory' do
  let(:input) { '.../nthis/nis/na/ntest' }
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

    context 'when the input is marked to be ignored (starting with a !)' do
      let(:input) { '!.../n!this/nis/n!a/ntest' }
      it 'drops these rows and returns the rest' do
        expect(subject.call).to eq(
          [
            %w[i s],
            %w[t e s t]
          ]
        )
      end
    end

    context 'when the input has invalid characters' do
      it 'exits and alerts the user'
    end
  end
end
