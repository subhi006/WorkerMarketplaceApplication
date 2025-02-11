class Adddetails < ActiveRecord::Migration[8.0]
  def change
    add_column :tasks, :start_date, :datetime
    add_column :tasks, :work_status, :integer
    add_column :profiles, :work_status, :integer
    add_column :profiles, :joining_status, :integer
  end
end
