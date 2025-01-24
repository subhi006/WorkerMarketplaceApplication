class Application < ApplicationRecord
  belongs_to :task
  belongs_to :user
  enum :stage, [ :applied, :selected, :joined, :regected ]
end
