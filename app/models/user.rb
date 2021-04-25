class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password_digest, require: true

  has_secure_token :api_key, key_length: 20
  has_secure_password
end