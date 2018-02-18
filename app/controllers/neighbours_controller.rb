class NeighboursController < ApplicationController
  def index
    @nodes = Node.all
  end

  def create
    binding.pry
  end

  private

  def permit_params

  end
end
