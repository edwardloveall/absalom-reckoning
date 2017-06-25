class Permission < ApplicationRecord
  LEVELS = %w(owner editor viewer).freeze

  belongs_to :calendar
  belongs_to :user

  validates :calendar, presence: true
  validates :level, presence: true, inclusion: { in: LEVELS }
  validates :user, presence: true

  def self.own
    %w(owner)
  end

  def self.edit
    %w(owner editor)
  end
end
