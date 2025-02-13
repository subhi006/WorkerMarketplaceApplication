class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :task
  validates :message, presence: true
  enum :status, [ :unread, :read ]
end
