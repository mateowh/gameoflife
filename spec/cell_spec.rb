require 'rspec'
require 'cell'

describe 'Cell' do
  let(:inital_state) { Cell::ALIVE }
  subject { Cell.new(inital_state) }

  it 'is a Cell object' do
    expect(subject.is_a?(Cell)).to be true
  end

  it 'is has alive state' do
    expect(subject.state).to eq(Cell::ALIVE)
  end

  context 'when created in dead state' do
    let(:inital_state) { Cell::DEAD }

    it 'is has dead state' do
      expect(subject.state).to eq(Cell::DEAD)
    end
  end
end
