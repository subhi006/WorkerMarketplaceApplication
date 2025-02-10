class Addexperienceprofile < ActiveRecord::Migration[8.0]
  def change
    add_column :profiles, :experience, :integer
    add_column :profiles, :skill, :string
    add_column :tasks, :experience, :integer
    add_column :profiles, :resume, :string
  end
end
