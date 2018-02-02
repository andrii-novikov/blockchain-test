class Node < ApplicationRecord
  validates :node_id, :url, presence: true
end
