class User < ActiveRecord::Base
  has_many :permissions
  has_many :calendars, through: :permissions

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
end
