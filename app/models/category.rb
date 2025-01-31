class Category < ApplicationRecord
  has_many :tasks, dependent: :destroy
  # Validations
  validates :name, presence: true, uniqueness: true
  # callbacks
  before_save :capitalize_name
  scope :all_present_category, -> { Category.all }


  def self.search_category(search)
    where("name LIKE ?", "%#{search}%")
  end

  def capitalize_name
    self.name = name.capitalize if name.present?
  end
end
