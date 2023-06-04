class BroadcastService
  class << self
    def call(notes: nil)
      broadcast_notes_table(notes)
      broadcast_counter
    end

    private

    def broadcast_notes_table(notes)
      return Rails.logger.error 'Unable to update broadcast for notes_table. Notes missing' unless notes

      Turbo::StreamsChannel.broadcast_replace_to('notes_table',
                                                 target: 'notes_table',
                                                 partial: 'notes/notes_table',
                                                 locals: { notes: notes })
    end

    def broadcast_counter
      Turbo::StreamsChannel.broadcast_update_to('counter', target: 'counter', partial: 'notes/counter')
    end
  end
end
