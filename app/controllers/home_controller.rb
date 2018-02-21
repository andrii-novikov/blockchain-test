class HomeController < ApplicationController
  def index
    @status = StatusService.call
  end

  def reset
    Block.destroy_all
    Transaction.destroy_all
    redirect_back fallback_location: :index
  end
end
