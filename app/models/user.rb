class User < ApplicationRecord
  has_many :events
   has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :role, presence: true
end
