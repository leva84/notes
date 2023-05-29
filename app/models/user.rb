class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :notes, dependent: :destroy

  validates :first_name, :last_name, length: { minimum: 3, maximum: 150 }

  def full_name
    "#{first_name} #{last_name}"
  end
end
