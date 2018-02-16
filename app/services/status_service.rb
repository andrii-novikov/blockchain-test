class StatusService < Rectify::Command
  def call
    {
      id: BlockchainWorkshop::Application.secrets[:node_id].to_s,
      name: BlockchainWorkshop::Application.secrets[:name],
      last_hash: Block.last_block_hash,
      neighbours: Node.pluck(:node_id).map(&:to_s),
      url: BlockchainWorkshop::Application.secrets[:url]
    }
  end
end