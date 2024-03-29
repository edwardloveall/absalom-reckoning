class Event < ApplicationRecord
  attribute :occurred_on, ArDate.new

  belongs_to :calendar

  scope :visible, -> { where(hidden_at: nil) }

  time_for_a_boolean :hidden

  validates :occurred_on, presence: true
  validates :title, presence: true
end
