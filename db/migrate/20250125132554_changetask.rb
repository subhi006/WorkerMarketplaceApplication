class Changetask < ActiveRecord::Migration[8.0]
  def change
    add_reference :tasks, :contractor, foreign_key: { to_table: :users }
    add_reference :applications, :worker, foreign_key: { to_table: :users }
  end
end
