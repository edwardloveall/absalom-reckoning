class Calendar < ApplicationRecord
  attribute :current_date, ArDate.new

  has_many :events, dependent: :destroy
  has_many :invitations, dependent: :destroy
  has_many :permissions, dependent: :destroy
  has_many :users, through: :permissions

  validates :current_date, presence: true
  validates :title, presence: true, length: { maximum: 100 }

  def events_for_month(around:)
    date = around
    start_date = date.beginning_of_month.beginning_of_week
    end_date = date.end_of_month.end_of_week
    month_range = start_date..end_date

    events.where(occurred_on: month_range)
  end
end
