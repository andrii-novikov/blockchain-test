class Transaction < ApplicationRecord
  TRANSACTIONS_IN_BLOCK = 5.freeze

  validates :from, presence: true
  validates :to, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }

  after_create :create_block, if: :enough_transactions?

  private

  def create_block
    BlockBuilderService.call
  end

  def enough_transactions?
    Transaction.count >= TRANSACTIONS_IN_BLOCK
  end
end
