class Permission < ApplicationRecord
  LEVELS = {
    own: 'owner',
    edit: 'editor',
    view: 'viewer'
  }.freeze

  belongs_to :calendar
  belongs_to :user

  validates :calendar, presence: true
  validates :level, presence: true, inclusion: { in: LEVELS.values }
  validates :user, presence: true
end
