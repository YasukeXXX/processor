class NameFormatValidator < ActiveModel::EachValidator
  VALID_NAME_REGEX = /\A[\w\d_-]+\z/i
  def validate_each(record, attribute, value)
    record.errors.add attribute, 'must be name format.' unless value.match(VALID_NAME_REGEX)
  end
end
