class SyncService < Rectify::Command
  def initialize(id)
    @node = id.blank? ? Node.first : Node.find_by(node_id: id)
    @logger = Rails.logger
    @error = nil
  end

  def call
    return broadcast :failure, 'Neighbour not found' unless node
    return node_error unless data

    if save_data
      broadcast :ok, "#{data.count} blocks was created"
    else
      broadcast :failure, "Broken chain. Couldn't create all blocks"
    end
  end

  private

  def save_data
    Block.destroy_all
    Transaction.destroy_all
    save_next_block('0')

    data.count == Block.count
  end

  def save_next_block(prev_hash)
    block = data.find { |b| b['prev_hash'].to_s == prev_hash }
    return unless block
    create_block(block)
    save_next_block(block['hash'])
  end

  def node_error
    node.destroy
    broadcast :failure, error
  end

  def create_block(block)
    Block.create(ts: block['ts'],
                 tx: block['tx'],
                 prev_hash: block['prev_hash'],
                 block_hash: block['hash'],
                 skip_notify_neighbours: true)
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