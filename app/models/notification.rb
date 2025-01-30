class Notification < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :task, dependent: :destroy
  validates :message, presence: true
end
