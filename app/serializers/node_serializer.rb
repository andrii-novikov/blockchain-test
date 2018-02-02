class NodeSerializer < ActiveModel::Serializer
  attribute :node_id, key: :id
  attribute :uri
end