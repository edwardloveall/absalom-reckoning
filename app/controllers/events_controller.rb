class EventsController < ApplicationController
  def new
    @event = calendar.events.new(occurred_on: date)
  end

  def create
    @event = calendar.events.new(event_params)

    if @event.save
      redirect_to calendar_path(calendar)
    end
  end

  private

  def event_params
    params[:event][:occurred_on] = date
    params.require(:event)
          .permit(:title, :occurred_on, :calendar)
          .merge(occurred_on: date)
  end

  def calendar
    Calendar.find(params[:calendar_id])
  end

  def date
    date_string = params[:date]
    ArDateParser.from_date_string(date_string)
  end
end
