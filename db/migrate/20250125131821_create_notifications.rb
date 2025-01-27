class CreateNotifications < ActiveRecord::Migration[8.0]
  def change
    create_table :notifications do |t|
      t.belongs_to :user
      t.belongs_to :task
      t.string :message
      t.integer :status
      t.integer :notifications
      t.datetime :sent_at
      t.timestamps
    end
  end
end
