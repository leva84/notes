class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, length: { minimum: 3, maximum: 150 }
end
