class CreateBlocks < ActiveRecord::Migration[5.1]
  def change
    create_table :blocks do |t|
      t.json :tx
      t.timestamp :ts
      t.string :hash
      t.string :prev_hash

      t.timestamps
    end
  end
end
