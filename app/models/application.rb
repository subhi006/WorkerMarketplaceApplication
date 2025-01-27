class Application < ApplicationRecord
  belongs_to :task
  belongs_to :user
  belongs_to :worker, class_name: "User"
  enum :status, [ :applied, :selected,  :rejected ]

  validates :worker_id, uniqueness: { scope: :task_id }
end
