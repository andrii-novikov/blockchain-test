class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.string :from
      t.string :to
      t.integer :amount

      t.timestamps
    end
  end
end
