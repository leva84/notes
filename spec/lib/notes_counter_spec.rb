RSpec.describe NotesCounter do
  let(:redis) { Redis.new }

  describe '#initialize' do
    context 'when the value of notes_count key in Redis is 0' do
      it 'sets the value of the notes_count key in Redis to the number of notes in the database' do
        expect(redis.get('notes_count')).to be_nil
        allow(Note).to receive(:count).and_return(10)
        described_class.new
        expect(redis.get('notes_count').to_i).to eq(10)
      end
    end

    context 'when the value of notes_count key in Redis is not equal to 0' do
      it 'does not change the value of notes_count key in Redis' do
        redis.set('notes_count', 5)
        allow(Note).to receive(:count)
        described_class.new
        expect(Note).not_to have_received(:count)
        expect(redis.get('notes_count').to_i).to eq(5)
      end
    end
  end

  describe '#increment' do
    it 'increments the counter by one' do
      expect { described_class.increment }.to change(described_class, :count).by(1)
    end

    it 'updates the counter value in Redis' do
      expect { described_class.increment }.to change { redis.get('notes_count').to_i }.by(1)
    end
  end

  describe '#decrement' do
    it 'decrements the counter value by one' do
      expect { described_class.decrement }.to change(described_class, :count).by(-1)
    end

    it 'updates the counter value in Redis' do
      expect { described_class.decrement }.to change { redis.get('notes_count').to_i }.by(-1)
    end
  end

  describe '#count' do
    it 'returns the current counter value' do
      expect(described_class.count).to eq(0)
      described_class.increment
      expect(described_class.count).to eq(1)
    end
  end
end
