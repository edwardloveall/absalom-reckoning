class Event < ApplicationRecord
  attribute :occurred_on, ArDate.new

  validates :occurred_on, presence: true
  validates :title, presence: true
end
