class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [ 100, 100 ]
  end
  validates :name, presence: true
  validates :contact_info, presence: true
end
