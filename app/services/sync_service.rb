class SyncService < Rectify::Command
  def initialize(id)
    @node = id.blank? ? Node.first : Node.find_by(node_id: id)
    @logger = Rails.logger
    @error = nil
  end

  def call
    return broadcast :failure, 'Neighbour not found' unless node
    return node_error unless data
    broadcast :ok, save_data
  end

  private

  def save_data
    Block.destroy_all
    Transaction.destroy_all
    data.map! { |block| create_block(block) }
  end

  def node_error
    node.destroy
    broadcast :failure, error
  end

  def create_block(block)
    binding.pry
    Block.create(ts: block['ts'], tx: block['tx'], prev_hash: block['prev_hash'], block_hash: block['hash'])
  end

  def data
    @data ||= fetch_data
  end

  def fetch_data
    json = Net::HTTP.get(node.sync_uri)
    JSON.parse(json)
  rescue => e
    @error = e.message
    logger.warn("sync failed: node: #{node.as_json}, error: #{e}")
    false
  end

  attr_reader :node, :logger, :error
end