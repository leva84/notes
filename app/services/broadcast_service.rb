class BroadcastService
  class << self
    def call(notes: nil, notes_count: nil)
      broadcast_notes_table(notes)
      broadcast_counter(notes_count)
    end

    private

    def broadcast_notes_table(notes)
      return Rails.logger.error 'Unable to update broadcast for notes_table. Notes missing' unless notes

      Turbo::StreamsChannel.broadcast_replace_to('notes_table',
                                                 target: 'notes_table',
                                                 partial: 'notes/notes_table',
                                                 locals: { notes: notes })
    end

    def broadcast_counter(notes_count)
      return Rails.logger.error 'Unable to update broadcast for counter. Notes count missing' unless notes_count

      Turbo::StreamsChannel.broadcast_update_to('counter',
                                                target: 'counter',
                                                partial: 'notes/counter',
                                                locals: { notes_count: notes_count })
    end
  end
end
