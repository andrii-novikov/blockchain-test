class BlockBuilderService < Rectify::Command
  def initialize
    @sha = Digest::SHA2.new
    @transactions = Transaction.order(created_at: :desc).limit(5)
    @tx = transactions.map { |t| TransactionSerializer.new(t).as_json }
    @ts = Time.zone.now.to_i
    @prev_hash = Block.last_block_hash
  end

  def call
    Block.create(tx: tx, ts: ts, prev_hash: prev_hash).tap do |block|
      transactions.destroy_all if block.persisted?
    end
  end

  private

  attr_reader :tx, :ts, :prev_hash, :transactions
end