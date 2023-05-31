class Note < ApplicationRecord
  belongs_to :user

  validates :user, :message, presence: true
  validates :message, length: { minimum: 3, maximum: 1000 }
end
