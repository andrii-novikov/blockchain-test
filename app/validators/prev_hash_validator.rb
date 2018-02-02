class PrevHashValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless Block.last_block_hash == value
      record.errors[attribute] << (options[:message] || "is not matched to last_block_hash")
    end
  end
end