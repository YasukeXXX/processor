class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true, length: { maximum: 50 }, name_format: true
  validates :email, presence: true, length: { maximum: 255 },
                    uniqueness: { case_sensitive: false }, email_format: true
  validates :password, presence: true, length: { minimum: 6 }

  has_one :account_activation, dependent: :destroy

  before_create :build_account_activation

  paginates_per 20

  def activate
    account_activation.update_attributes(activated: true, activated_at: Time.zone.now)
  end

  def self.activated_all
    User.where(id: AccountActivation.where(activated: true).ids)
  end
end
