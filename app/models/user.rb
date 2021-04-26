class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates :password_digest, presence: { require: true }
  validates :password, confirmation: true

  before_save :normalize_email

  has_secure_token :api_key
  has_secure_password

  private

  def normalize_email
    self.email = email.downcase if email.present?
  end
end
