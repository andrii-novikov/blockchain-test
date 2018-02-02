class SendUpdateService < Rectify::Command
  def initialize(block)
    @block = block
    @json = { block: BlockSerializer.new(block).as_json,
              sender_id: BlockchainWorkshop::Application.secrets[:node_id] }.to_json
    @logger = Rails.logger
  end

  def call
    Node.where.not(node_id: block.sender_id).find_each do |node|
      result = notify(node)
      logger.info("Notify node #{node.node_id}: #{node.url}. Result: #{result.body}")
    end
  end

  private

  def notify(node)
    Net::HTTP.post(node.update_uri, json, "Content-Type" => "application/json" )
  end

  attr_reader :block, :json, :logger
end