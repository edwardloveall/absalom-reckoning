class Permission < ApplicationRecord
  LEVELS = %w(owner editor viewer).freeze

  belongs_to :calendar
  belongs_to :user

  validates :calendar, presence: true
  validates :level, presence: true, inclusion: { in: LEVELS }
  validates :user, presence: true
end