class ManagementController < ApplicationController
  def add_link
    node = Node.create(node_id: link_params[:id], url: link_params[:url])
    respond_with node
  end

  def add_transaction
    transaction = Transaction.create(transaction_params)
    respond_with transaction
  end

  def status
    status = { id: BlockchainWorkshop::Application.secrets[:node_id],
               name: BlockchainWorkshop::Application.secrets[:name],
               last_hash: Block.last_block_hash,
               neighbours: Node.pluck(:node_id),
               url: BlockchainWorkshop::Application.secrets[:url] }
    respond_with status
  end

  def sync
    
  end

  private

  def link_params
    params.permit(:id, :url)
  end

  def transaction_params
    params.permit(:from, :to, :amount)
  end
end
