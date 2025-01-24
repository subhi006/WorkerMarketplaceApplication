class Task < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :applications
  # has_many :user, through: :applications
  # has_many :user, through: :applications
  enum :status, [ :available, :notavailable ]

  def current_status
     if number_of_position <= 0
       status = "not_available"
     end
     status
  end
end
