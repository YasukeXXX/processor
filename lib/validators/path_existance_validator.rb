class PathExistanceValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add attribute, "incorrect: #{value}" unless File.exist?(Rails.root.join value)
  end
end
