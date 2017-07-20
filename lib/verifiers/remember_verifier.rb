class Verifier
  def initialize(type: :remember, expiration_date: 30.years)
    @verifier = verifier(type)
    @expiration_date = expiration_date
  end

  def generate_token(message)
    @verifier.generate([message, Time.zone.now])
  end

  def verify(token)
    if @verifier.valid_message?(token) && (message, time = @verifier.verify(token))
      return message if time > @expiration_date.ago
    end
    nil
  end

  private

  def verifier(type)
    Rails.application.message_verifier(type)
  end
end
