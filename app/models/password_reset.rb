class PasswordReset
  def token
    @token ||= reset_verifier.generate_token(user.id)
  end

  def verify(token)
    reset_verifier.verify(token)
  end

  private

  def reset_verifier
    @reset_verifier ||= Verifier.new type: :reset, expiration_date: 3.hours
  end
end
