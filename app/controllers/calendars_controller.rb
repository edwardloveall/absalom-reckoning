class CalendarsController < ApplicationController
  def show
    @calendar = Calendar.find(params[:id])
    if params[:date].present?
      @date = ArDate.parse(params[:date])
    else
      @date = ArDate.new
    end

    @events = EventFilterer.new(@calendar.events_for_month(around: @date))
  end
end
