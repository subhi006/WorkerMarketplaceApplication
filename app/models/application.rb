class Application < ApplicationRecord
  belongs_to :task
  belongs_to :worker, class_name: "User"
  enum :status, [ :applied, :approved,  :rejected ]
  # validations
  validates :worker_id, uniqueness: { scope: :task_id }
  # callbcacks
end
