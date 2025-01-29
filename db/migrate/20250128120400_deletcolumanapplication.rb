class Deletcolumanapplication < ActiveRecord::Migration[8.0]
  def up
    remove_column :applications, :user_id
  end
  def down
    raise ActiveRecord::IrreversibleMigration, "This migration cannot be reverted because it destroys data."
  end
end
