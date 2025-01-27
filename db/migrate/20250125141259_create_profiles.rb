class CreateProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.text :bio
      t.string :contact_info
      t.string :address
      t.string :avatar
      t.timestamps
    end
  end
end
