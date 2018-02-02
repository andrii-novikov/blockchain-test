class CreateBlocks < ActiveRecord::Migration[5.1]
  def change
    create_table :blocks do |t|
      t.json :tx
      t.integer :ts
      t.string :block_hash
      t.string :prev_hash

      t.timestamps
    end
  end
end
