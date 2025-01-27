class Changetask < ActiveRecord::Migration[8.0]
  def change
    add_reference :tasks, :contractor, null: false, foreign_key: { to_table: :users }
    add_reference :applications, :worker, null: false, foreign_key: { to_table: :users }
  end
end
