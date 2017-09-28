class Invitation < ApplicationRecord
  belongs_to :calendar
  belongs_to :owner, class_name: 'User'

  validates :calendar, presence: true
  validates :email, presence: true, uniqueness: { scope: :calendar_id }
  validates :owner, presence: true
end
