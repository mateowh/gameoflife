require 'rspec'
require 'cell'

describe 'Cell' do
  let(:inital_state) { Cell::ALIVE }
  subject { Cell.new(inital_state) }

  it 'is a Cell object' do
    expect(subject.is_a?(Cell)).to be true
  end

  context 'when created as alive' do
    it 'is has alive state' do
      expect(subject.state).to eq(Cell::ALIVE)
    end

    it 'can be killed' do
      subject.state = Cell::DEAD
      expect(subject.state).to eq(Cell::DEAD)
    end
  end

  context 'when created as dead' do
    let(:inital_state) { Cell::DEAD }

    it 'is has dead state' do
      expect(subject.state).to eq(Cell::DEAD)
    end

    it 'can be revived' do
      subject.state = Cell::ALIVE
      expect(subject.state).to eq(Cell::ALIVE)
    end
  end

  describe 'kill!' do
    it 'kills the cell' do
      expect { subject.kill! }.to change { subject.state }.from(Cell::ALIVE).to(Cell::DEAD)
    end

    context 'when cell is already dead' do
      let(:inital_state) { Cell::DEAD }
      it 'has no effect' do
        expect { subject.kill! }.not_to change(subject, :state)
      end
    end
  end

  describe 'revive!' do
    it 'has no effect on a live cell' do
      expect { subject.revive! }.not_to change(subject, :state)
    end

    context 'when the cell is dead' do
      let(:inital_state) { Cell::DEAD }
      it 'changes the state to alive' do
        expect { subject.revive! }.to change { subject.state }.from(Cell::DEAD).to(Cell::ALIVE)
      end
    end
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
