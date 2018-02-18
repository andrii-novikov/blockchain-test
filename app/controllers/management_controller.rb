class ManagementController < ApiController
  respond_to :json

  def add_link
    node = Node.create(node_id: link_params[:id], url: link_params[:url])
    respond_with node
  end

  def add_transaction
    transaction = Transaction.create(transaction_params)
    respond_with transaction
  end

  def status
    render json: StatusService.call
  end

  def sync
    SyncService.call(params[:id]) do
      on(:ok) { |data| success data }
      on(:failure) { |error| failure error }
    end
  end

  def all_status
    render json: AllStatusService.call
  end

  private

  def link_params
    params.permit(:id, :url)
  end

  def transaction_params
    params.permit(:from, :to, :amount)
  end
end
