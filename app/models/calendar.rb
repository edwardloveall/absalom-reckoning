class Calendar < ApplicationRecord
  has_many :events
  has_many :permissions
  has_many :users, through: :permissions

  def self.events_for_month(around:)
    date = around
    start_date = date.beginning_of_month.beginning_of_week
    end_date = date.end_of_month.end_of_week
    month_range = start_date..end_date

    Event.where(occurred_on: month_range)
  end
end
