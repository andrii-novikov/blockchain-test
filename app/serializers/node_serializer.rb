class TransactionSerializer < ActiveModel::Serializer
  attribute :node_id, key: :id
  attribute :url
end