class Application < ApplicationRecord
  belongs_to :task
  belongs_to :worker, class_name: "User"
  enum :status, [ :applied, :approve,  :rejected ]

  validates :worker_id, uniqueness: { scope: :task_id }
end
