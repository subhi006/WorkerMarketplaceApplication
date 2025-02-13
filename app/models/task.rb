class Task < ApplicationRecord
  # Associations
  belongs_to :category
  belongs_to :contractor, class_name: "User"
  has_many :applications, dependent: :destroy
  has_many :workers, through: :applications
  has_many :notifications, dependent: :destroy
  enum :status, [ :not_available, :available ]
  enum :work_status, [ :closed, :start ]

  # after_create :send_creation_notification
  # Validations
  # validates :category, presence: true
  validates :salary, :company, :description, :location, presence: true
  validates :category, presence: { message: "Category must be selected" }
  validates :location, presence: { message: "Location cannot be blank" }
  validates :company, presence: { message: "Company cannot be blank" }
  validates :salary, presence: { message: "Salary must be provided" }, numericality: { greater_than: 0, message: "Salary must be greater than 0" }
  validates :experience, presence: { message: "Experience must be mention" }, numericality: { greater_than: -1, message: "experience must be 0 or greater than 0" }

  before_save :capitalize_fields

  def current_status
     if number_of_position <= 0
        "Not Available"
     else
        "Available"
     end
  end

  scope :application_count, lambda {
    left_joins(:applications)
      .group("tasks.id")
      .order("COUNT(applications.id)")
    }

    def capitalize_fields
      self.location = location.capitalize if location.present?
      self.company = company.capitalize if company.present?
      self.description = description.capitalize if description.present?
    end
end
