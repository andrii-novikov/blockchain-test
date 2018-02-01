class CreateNodes < ActiveRecord::Migration[5.1]
  def change
    create_table :nodes do |t|
      t.integer :node_id
      t.string :url

      t.timestamps
    end
  end
end
