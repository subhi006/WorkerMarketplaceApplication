class Changetype < ActiveRecord::Migration[8.0]
  def up
    change_column :tasks, :duration, 'integer USING duration::integer'
  end

  def down
    change_column :tasks, :duration, :string  # or the original type
  end
end
