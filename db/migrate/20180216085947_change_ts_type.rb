class ChangeTsType < ActiveRecord::Migration[5.1]
  def up
    change_column :blocks, :ts, :bigint
  end

  def down
    change_column :blocks, :ts, :integer
  end
end
