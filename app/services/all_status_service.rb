class AllStatusService < Rectify::Command
  def call
    current_status.tap do |result|
      Node.find_each { |node| result[node.node_id] = fetch_status(node) }
    end
  end

  private

  def current_status
    { current: StatusService.call }
  end

  def fetch_status(node)
    JSON.parse(Net::HTTP.get(node.status_uri))
  rescue => e
    e.message
  end
end