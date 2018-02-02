class BlockchainController < ApplicationController
  def receive_update
    ReceiveUpdateService.call(new_block_hash, block_params, sender_id) do
      on(:failure) { |block| respond_with block }
      on(:ok) { |block, status| success(block, status: status) }
    end
  end

  def get_blocks
    count = params[:count].to_i
    respond_with Block.get_blocks(count)
  end

  private

  def block_params
    params.require(:block).permit(:ts, :prev_hash, tx: [:from, :to, :amount])
  end

  def new_block_hash
    params[:block][:hash]
  end

  def sender_id
    params[:sender_id]
  end
end
