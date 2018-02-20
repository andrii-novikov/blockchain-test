class NeighboursController < ApplicationController
  before_action :set_node

  def index
    @nodes = Node.all
  end

  def create
    if @node.save
      redirect_back(fallback_location: neighbours_path)
    else
      @nodes = Node.all
      render('index')
    end
  end

  private

  def set_node
    @node = Node.new(permitted_params)
  end

  def permitted_params
    params.fetch(:node, {}).permit(:node_id, :url)
  end
end
