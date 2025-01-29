class Addexperienceprofile < ActiveRecord::Migration[8.0]
  def change
    add_column :profiles, :experience, :integer
    add_column :tasks, :experience, :integer
  end
end
