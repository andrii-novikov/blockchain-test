class ChangeNodeIdType < ActiveRecord::Migration[5.1]
  def up
    change_column :nodes, :node_id, :string
  end

  def down
    change_column :nodes, :node_id, :integer
  end
end
