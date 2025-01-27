class Task < ApplicationRecord
  # Associations
  belongs_to :category
  belongs_to :contractor, class_name: "User"
  has_many :workers, through: :applications
  has_many :applications, dependent: :destroy
  # accepts_nested_attributes_for :applications, counter_cache: true
  enum :status, [ :available, :notavailable ]

  # after_create :send_creation_notification
  # Validations
  validates :salary, :company, :location, presence: true
  def current_status
     if number_of_position <= 0
       status = "not_available"
     end
     status
  end

  scope :application_count, lambda {
    left_joins(:applications)
      .group("tasks.id")
      .order("COUNT(applications.id)")
    }

  # def send_creation_notification
  #   Notification.create(
  #     user_id: contractor.id,
  #     task_id: id,
  #     message: "Your task has been created successfully",
  #     notification_type: :email
  #   )
  # end
end
