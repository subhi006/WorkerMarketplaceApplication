class Task < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :applications
  # has_many :user, through: :applications
  # has_many :user, through: :applications

  belongs_to :contractor, class_name: "User"
  has_many :workers, through: :applications
  has_many :applications, dependent: :destroy
  # accepts_nested_attributes_for :applications, counter_cache: true
  enum :status, [ :available, :notavailable ]

  # after_create :send_creation_notification

  def current_status
     if number_of_position <= 0
       status = "not_available"
     end
     status
  end

  scope :application_count, lambda {
    left_joins(:applications)
      .group("tasks.id")
      .order("COUNT(applications.id) ")
    }
   def applications_count_or_default
      applications_count || 0
   end

  # def send_creation_notification
  #   Notification.create(
  #     user_id: contractor.id,
  #     task_id: id,
  #     message: "Your task has been created successfully",
  #     notification_type: :email
  #   )
  # end
end
