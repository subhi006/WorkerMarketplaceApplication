class Review < ApplicationRecord
  has_many :reviewers, class_name: "User", foreign_key: "user_id"
  belongs_to :user, class_name: "User", foreign_key: "user_id", required: true
  validates :review, presence: true
  validates :rating, presence: true
end
