class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, [ :worker, :contractor ]
  # associations
  has_many :tasks, foreign_key: :contractor_id
  has_many :applications, foreign_key: :worker_id
  has_many :applied_task, through: :applications, source: :task
  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile

  # validations
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  def full_name
    "#{first_name} #{last_name}"
  end
  def apply(task)  # need a task object for creating application
        self.applied_task << task
  end
end
