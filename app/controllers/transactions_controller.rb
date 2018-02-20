class TransactionsController < ApplicationController
  before_action :set_transaction

  def index
    @transactions = Transaction.all
  end

  def create
    if @transaction.save
      redirect_back(fallback_location: transactions_path)
    else
      @transactions = Transaction.all
      render('index')
    end
  end

  private

  def set_transaction
    @transaction = Transaction.new(transaction_params)
  end

  def transaction_params
    params.fetch(:transaction, {}).permit(:from, :to, :amount)
  end
end
