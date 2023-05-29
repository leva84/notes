class Note < ApplicationRecord
  belongs_to :user

  after_create_commit :broadcast_create

  validates :user, :message, presence: true
  validates :message, length: { minimum: 3, maximum: 1000 }

  private

  def broadcast_create
    Turbo::StreamsChannel.broadcast_append_to :notes,
                                              target: 'notes_table',
                                              partial: 'notes/note',
                                              locals: { note: self }
  end
end
