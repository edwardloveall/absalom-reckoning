class Invitation < ApplicationRecord
  belongs_to :calendar
  belongs_to :owner, class_name: 'User'

  time_for_a_boolean :accepted

  validates :calendar, presence: true
  validates :email, presence: true, uniqueness: { scope: :calendar_id }
  validates :level, presence: true, inclusion: {
    in: Permission::INVITATION_LEVELS
  }
  validates :owner, presence: true
end
