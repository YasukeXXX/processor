class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true, length: { maximum: 50 },
                   name_format: true
  validates :email, presence: true, length: { maximum: 255 },
                    uniqueness: { case_sensitive: false },
                    email_format: true
  validates :password, presence: true, length: { minimum: 6 }

  has_one :account_activation
end
