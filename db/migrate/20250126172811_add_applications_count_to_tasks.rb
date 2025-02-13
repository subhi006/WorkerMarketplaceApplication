class AddApplicationsCountToTasks < ActiveRecord::Migration[8.0]
  def change
    add_column :tasks, :applications_count, :integer
    add_column :tasks, :status, :integer
  end
end
