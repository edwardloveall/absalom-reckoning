class Event < ApplicationRecord
  attribute :occurred_on, ArDate.new

  belongs_to :calendar

  validates :occurred_on, presence: true
  validates :title, presence: true
end
