class Event < ApplicationRecord
  validates :occurred_on, presence: true
  validates :title, presence: true
end
