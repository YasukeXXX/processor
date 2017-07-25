class PathExistanceValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add attribute, 'incorrect path' unless File.exist?(value)
  end
end
