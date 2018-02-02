class BlockchainController < ApplicationController
  def receive_update

  end

  def get_blocks
    count = params[:count].to_i
    respond_with Block.get_blocks(count)
  end
end
