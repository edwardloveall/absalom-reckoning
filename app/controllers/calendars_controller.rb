class CalendarsController < ApplicationController
  def index
    if params[:date].present?
      @date = ArDate.parse(params[:date])
    else
      @date = ArDate.new
    end
    event_start = @date.beginning_of_month.beginning_of_week
    event_end = @date.end_of_month.end_of_week
    month_range = event_start..event_end
    @events = EventFilterer.new(Event.where(occurred_on: month_range))
  end
end
