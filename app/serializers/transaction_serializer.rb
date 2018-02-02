class TransactionSerializer < ActiveModel::Serializer
  attributes :from, :to, :amount
end