RSpec.describe BroadcastService do
  describe '#call' do
    context 'when notes is not nil' do
      let(:notes) { double }

      before do
        allow(described_class).to receive(:broadcast_notes_table)
        allow(described_class).to receive(:broadcast_counter)
      end

      it 'calls broadcast_notes_table with notes' do
        described_class.call(notes: notes)
        expect(described_class).to have_received(:broadcast_notes_table).with(notes)
      end

      it 'calls broadcast_counter' do
        described_class.call(notes: notes)
        expect(described_class).to have_received(:broadcast_counter)
      end
    end

    context 'when notes is nil' do
      let(:notes) { nil }

      before { allow(Rails.logger).to receive(:error) }

      it 'logs an error' do
        described_class.call(notes: notes)
        expect(Rails.logger).to have_received(:error).with('Unable to update broadcast for notes_table. Notes missing')
      end
    end
  end
end
