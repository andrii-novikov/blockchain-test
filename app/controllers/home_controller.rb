class HomeController < ApplicationController
  def index
    @status = StatusService.call
  end

  def neighbours
    @nodes = Node.all
  end

  def blocks
    @blocks = Block.all
  end

  def transactions
    @transactions = Transaction.all
  end

  def create_transaction
    @transactions = Transaction.all
  end
end
