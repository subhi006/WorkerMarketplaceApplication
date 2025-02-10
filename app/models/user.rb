class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, [ :worker, :contractor, :admin ]
  # associations
  has_many :tasks, foreign_key: :contractor_id, dependent: :destroy
  has_many :applications, foreign_key: :worker_id
  has_many :applied_task, through: :applications, source: :task
  has_one :profile, dependent: :destroy
  has_many :notifications, dependent: :destroy
  # accepts_nested_attributes_for :profile

  # validations
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true, phone: true
  # call back
  before_save :capitalize_name
  after_create :congrats_email
  def full_name
    "#{first_name} #{last_name}"
  end

  def search(key)
    if key.present?
      @ans = Profile.where("experience Like", key+"%")
    else
      @ans = Profile.all
    end
  end

  def apply(task)
    self.applied_task << task
  end
  def capitalize_name
    self.first_name = first_name.capitalize if first_name.present?
    self.last_name = last_name.capitalize if last_name.present?
  end
  def congrats_email
    # mail(to: self.email, subject: "Welcome Message")
    UserMailer.with(user: self).welcome_email.deliver_later
  end
end
