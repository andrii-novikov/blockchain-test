class Block < ApplicationRecord
  DEFAULT_HASH = '0'.freeze
  attr_accessor :sender_id, :skip_notify_neighbours
  validates :prev_hash, prev_hash: true, on: :create
  validates :tx, :ts, :prev_hash, presence: true

  before_create :create_hash, if: :block_hash_blank?
  after_create :notify_neighbours

  delegate :blank?, to: :block_hash, prefix: true

  def self.last_block_hash
    order(created_at: :desc).limit(1).pluck(:block_hash).first || DEFAULT_HASH
  end

  def self.get_blocks(n = 10, prev_hash = last_block_hash)
    return [] if n.zero? || prev_hash == DEFAULT_HASH
    block = find_by(block_hash: prev_hash)
    get_blocks(n.pred, block.prev_hash) + [block]
  end

  private

  def notify_neighbours
    SendUpdateService.call(self) unless skip_notify_neighbours
  end

  def data
    prev_hash + ts.to_s + tx.map { |t| t['from'] + t['to'] + t['amount'].to_s }.join
  end

  def create_hash
    self.block_hash = Digest::SHA2.hexdigest(data)
  end
end