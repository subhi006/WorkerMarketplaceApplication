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
  def full_name
    "#{first_name} #{last_name}"
  end
end
