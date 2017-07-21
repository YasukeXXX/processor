class NameFormatValidator < ActiveModel::EachValidator
  VALID_NAME_REGEX = /\A[\w\d_-]+\z/i
  def validate_each(record, attribute, value)
    record.errors.add attribute, 'cannot use special character except "_".' unless value.match(VALID_NAME_REGEX)
  end
end
