class BlockSerializer < ActiveModel::Serializer
  attributes :ts, :tx, :prev_hash
  attribute :block_hash, key: :hash
end