class EmailFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add attribute, 'must be email format.' unless kawaii_email_address(value).valid?
  end

  private

  def kawaii_email_address(email)
    KawaiiEmailAddress::Validator.new(email)
  end
end
