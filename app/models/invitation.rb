class Invitation < ApplicationRecord
  belongs_to :calendar
  belongs_to :owner, class_name: 'User'
  has_one :permission

  scope :pending, -> { where(accepted_at: nil) }

  time_for_a_boolean :accepted

  validates :calendar, presence: true
  validates :email, presence: true, uniqueness: { scope: :calendar_id }
  validates :level, presence: true, inclusion: {
    in: Permission::INVITATION_LEVELS
  }
  validates :owner, presence: true

  def accept!
    update(accepted: true)
  end
end
