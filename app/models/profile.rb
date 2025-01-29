class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :avatar
  validates :name, presence: true
  validates :contact_info, presence: true
end
