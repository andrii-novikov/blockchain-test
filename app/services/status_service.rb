class StatusService < Rectify::Command
  def call
    {
      id: BlockchainWorkshop::Application.secrets[:node_id],
      name: BlockchainWorkshop::Application.secrets[:name],
      last_hash: Block.last_block_hash,
      neighbours: Node.pluck(:node_id),
      url: BlockchainWorkshop::Application.secrets[:url]
    }
  end
end