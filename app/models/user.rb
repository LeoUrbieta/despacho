class User < ApplicationRecord
  has_secure_password

  validates :password, presence: true, length: { minimum: 5 }
end
