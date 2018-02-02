class Block < ApplicationRecord
  DEFAULT_HASH = '0'.freeze
  validates :tx, :ts, :prev_hash, presence: true
  validate :validate_prev_hash

  before_create :create_hash, if: :block_hash_blank?

  delegate :blank?, to: :block_hash, prefix: true

  def self.last_block_hash
    order(created_at: :desc).limit(1).pluck(:block_hash).first || DEFAULT_HASH
  end

  def self.get_last(n)
    order(created_at: :desc).limit(n)
  end

  private

  def validate_prev_hash
    errors.add(:prev_hash, "doesn't matched") unless prev_hash == Block.last_block_hash
  end

  def data
    prev_hash + ts.to_s + tx.map { |t| t['from'] + t['to'] + t['amount'].to_s }.join
  end

  def create_hash
    self.block_hash = Digest::SHA2.hexdigest(data)
  end
end
