class AccountActivation < ApplicationRecord
  belongs_to :user

  def token
    @token ||= activation_verifier.generate_token(user_id)
  end

  def verify(token)
    activation_verifier.verify(token)
  end

  private

  def activation_verifier
    @activation_verifier ||= Verifier.new type: :activation
  end
end
