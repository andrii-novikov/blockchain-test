class ReceiveUpdateService < Rectify::Command
  def initialize(new_block_hash, block_params, sender_id)
    @block = Block.where(block_hash: new_block_hash).first_or_initialize
    @block.sender_id = sender_id
    @block_params = block_params
    @status = @block.persisted? ? :ok : :created
  end

  def call
    block.update(block_params) if newer_block?
    return broadcast(:failure, block) if block.invalid?
    broadcast(:ok, block, status)
  end

  private

  def newer_block?
    @block.ts.blank? || block_params[:ts].to_i > @block.ts
  end

  attr_reader :block, :block_params, :status
end