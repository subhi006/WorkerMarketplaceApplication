class Task < ApplicationRecord
  # Associations
  belongs_to :category, dependent: :destroy
  belongs_to :contractor, class_name: "User", dependent: :destroy
  has_many :workers, through: :applications
  has_many :applications, dependent: :destroy
  # accepts_nested_attributes_for :applications, counter_cache: true
  enum :status, [ :unavailable, :available ]

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

    def self.search(search)
              if @task=Task.where(category_id: Category.search_category(search).ids, status: "available")
                  @task
              else
                @task=Task.where(status: "available")
              end
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
