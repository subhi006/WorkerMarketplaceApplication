class Category < ApplicationRecord
  has_many :tasks
  validates :name, presence: true, uniqueness: true

  scope :all_present_category, -> { Category.all }


  def self.search_category(search)
    where("name LIKE ?", "%#{search}%")
  end
end
