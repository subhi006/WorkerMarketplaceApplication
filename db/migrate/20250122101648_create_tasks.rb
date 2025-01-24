class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :duration
      t.decimal :salary
      t.string :location
      t.time :sift_hours
      t.integer :sift
      t.string :company
      t.string :description
      t.integer :status
      t.integer :number_of_position
      t.belongs_to :category
      t.belongs_to :user
      t.timestamps
    end
  end
end
