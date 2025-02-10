class CreateApplications < ActiveRecord::Migration[8.0]
  def change
    create_table :applications do |t|
      t.belongs_to :user
      t.belongs_to :task
      t.integer :status
      t.timestamps
    end
  end
end
