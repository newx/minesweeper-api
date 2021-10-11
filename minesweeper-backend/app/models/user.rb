class User < ApplicationRecord
  has_many :games, dependent: :destroy

  validates :email, presence: true, uniqueness: true, email: true
  validates :password, presence: true, length: { minimum: 6 }

  has_secure_password
end
