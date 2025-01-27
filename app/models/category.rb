class Category < ApplicationRecord
  has_many :tasks
  validates :name, presence: true, uniqueness: true

  scope :all_present_category, -> { Category.all }
end
