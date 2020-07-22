require 'rspec'
require 'cell'

describe 'Cell' do
  let(:inital_state) { Cell::ALIVE }
  subject { Cell.new(inital_state) }

  it 'is a Cell object' do
    expect(subject.is_a?(Cell)).to be true
  end

  context 'when created in alive state' do
    it 'is has alive state' do
      expect(subject.state).to eq(Cell::ALIVE)
    end

    it 'can be killed' do
      subject.state = Cell::DEAD
      expect(subject.state).to eq(Cell::DEAD)
    end
  end

  context 'when created in dead state' do
    let(:inital_state) { Cell::DEAD }

    it 'is has dead state' do
      expect(subject.state).to eq(Cell::DEAD)
    end

    it 'can be revived' do
      subject.state = Cell::ALIVE
      expect(subject.state).to eq(Cell::ALIVE)
    end
  end

  describe 'kill' do
    it 'responds'
  end

  describe 'revive' do
    it 'responds'
  end

  describe 'alive?' do
    context 'when cell is alive' do
      it 'responds true' do
        expect(subject.alive?).to be true
      end
    end

    context 'when cell is dead' do
      let(:inital_state) { Cell::DEAD }
      it 'responds false' do
        expect(subject.alive?).to be false
      end
    end
  end

  describe 'dead?' do
    context 'when cell is alive' do
      it 'responds false' do
        expect(subject.dead?).to be false
      end
    end

    context 'when cell is dead' do
      let(:inital_state) { Cell::DEAD }
      it 'responds true' do
        expect(subject.dead?).to be true
      end
    end
  end
end
