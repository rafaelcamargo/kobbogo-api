class User < ApplicationRecord
  validates :username, :password_digest, presence: true
  validates :username, uniqueness: true

  has_secure_password
end
