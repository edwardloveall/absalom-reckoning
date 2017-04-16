class CalendarsController < ApplicationController
  def index
    if params[:date].present?
      @date = ArDate.parse(params[:date])
    else
      @date = ArDate.new
    end

    @events = EventFilterer.new(Calendar.events_for_month(around: @date))
  end
end
