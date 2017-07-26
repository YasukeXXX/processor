class PathExistanceValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    path = Rails.root.join value
    record.errors.add attribute, "incorrect: #{path}" unless File.exist? path
  end
end
