class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.all
    @transaction = Transaction.new
  end

  def create
    @transactions = Transaction.all
    @transaction = Transaction.create(transaction_params)
    @transaction.valid? ? redirect_back(fallback_location: transactions_path) : render('index')
  end

  private

  def transaction_params
    params.require(:transaction).permit(:from, :to, :amount)
  end
end
