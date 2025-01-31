class Task < ApplicationRecord
  # Associations
  belongs_to :category
  belongs_to :contractor, class_name: "User"
  has_many :applications, dependent: :destroy
  has_many :workers, through: :applications
  # accepts_nested_attributes_for :applications, counter_cache: true
  enum :status, [ :unavailable, :available ]

  # after_create :send_creation_notification
  # Validations
  # validates :category, presence: true
  validates :salary, :company, :description, :location, presence: true
  validates :category, presence: { message: "Category must be selected" }
  validates :location, presence: { message: "Location cannot be blank" }
  validates :company, presence: { message: "Company cannot be blank" }
  validates :salary, presence: { message: "Salary must be provided" }, numericality: { greater_than: 0, message: "Salary must be greater than 0" }

  before_save :capitalize_fields

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

    # def self.search(search)
    #   if @task=Task.where(category_id: Category.search_category(search).ids, status: "available")
    #     @task
    #   else
    #     @task=Task.where(status: "available")
    #   end
    # end
    def capitalize_fields
      self.location = location.capitalize if location.present?
      self.company = company.capitalize if company.present?
      self.description = description.capitalize if description.present?
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
