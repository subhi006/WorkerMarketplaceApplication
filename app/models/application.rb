class Application < ApplicationRecord
  belongs_to :task
  belongs_to :worker
  enum :stage, [ :applied, :selected, :joined, :regected ]
end
