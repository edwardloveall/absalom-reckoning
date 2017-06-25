class User < ActiveRecord::Base
  has_many :permissions
  has_many :calendars, through: :permissions

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  def can_own?(calendar)
    permissions.where(calendar: calendar, level: Permission.own).any?
  end

  def can_edit?(calendar)
    permissions.where(calendar: calendar, level: Permission.edit).any?
  end
end
