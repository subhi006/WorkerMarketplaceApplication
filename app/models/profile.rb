require "open3"
# require "carrierwave/orm/activerecord"
class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :avatar
  has_one_attached :myresume
  mount_uploader :resume, ResumeUploader
  validates :name, presence: true, uniqueness: { message: "should enter unique name" }
  validates :contact_info, presence: true
  validates :experience, presence: true
  validate :check_avatar_presence
  validate :check_myresume_presence

  enum :work_status, [ :open, :assigned, :completed ]

  # validate :check_resume_presence
  def check_avatar_presence
    errors.add(:avatar, "no file added") unless avatar.attached?
  end
  def check_myresume_presence
    errors.add(:resume, "no file added") unless resume.attached?
  end
end
