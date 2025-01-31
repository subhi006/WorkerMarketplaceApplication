require "open3"
class Profile < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_one_attached :avatar
  has_one_attached :resume
  validates :name, presence: true
  validates :contact_info, presence: true
  validate :check_avatar_presence
  # validate :check_resume_presence
  def check_avatar_presence
    errors.add(:avatar, "no file added") unless avatar.attached?
  end
  def check_resume_presence
    errors.add(:resume, "no file added") unless resume.attached?
  end
end
