class EmailFormatValidator < ActiveModel::EachValidator
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  def validate_each(record, attribute, value)
    record.errors.add attribute, 'must be email format.' unless value.match(VALID_EMAIL_REGEX)
  end
end
