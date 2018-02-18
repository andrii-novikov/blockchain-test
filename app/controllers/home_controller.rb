class HomeController < ApplicationController
  def index
    @status = StatusService.call
    @blocks = Block.all
    @transactions = Transaction.all

    render 'home/index'
  end
end
