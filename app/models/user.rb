class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :notes, dependent: :destroy

  validates :first_name, :last_name, length: { minimum: 3, maximum: 150 }

  before_validation :set_default_name, on: :create

  def full_name
    "#{first_name} #{last_name}"
  end

  protected

  def email_required?
    return false if persisted?

    super
  end

  private

  def set_default_name
    self.first_name = 'User'
    self.last_name = rand(1..1000).to_s
  end
end
