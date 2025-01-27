class Application < ApplicationRecord
  belongs_to :task
  belongs_to :user
  enum :stage, [ :applied, :selected, :joined, :regected ]
  belongs_to :worker, class_name: "User"
  enum :status, [ :applied, :selected,  :rejected ]

  validates :worker_id, uniqueness: { scope: :task_id }
end
