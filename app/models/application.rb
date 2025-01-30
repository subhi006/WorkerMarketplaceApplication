class Application < ApplicationRecord
  belongs_to :task, dependent: :destroy
  belongs_to :worker, class_name: "User", dependent: :destroy
  enum :status, [ :applied, :approved,  :rejected ]

  validates :worker_id, uniqueness: { scope: :task_id }
end
