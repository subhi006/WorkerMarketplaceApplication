class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, [ :worker, :contractor ]


  # has_one :worker
  # has_one :contractor
  has_many :tasks
  has_many :applications
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
end
