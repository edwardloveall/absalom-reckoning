class EventsController < ApplicationController
  def new
    @event = calendar.events.new
  end

  def create
    @event = calendar.events.new(event_params)

    if @event.save
      redirect_to calendar_path(calendar)
    end
  end

  def edit
    @calendar = calendar
    @event = @calendar.events.find(params[:id])
  end

  def update
    @calendar = calendar
    @event = @calendar.events.find(params[:id])

    if @event.update(event_params)
      redirect_to calendar_path(@calendar)
    end
  end

  private

  def event_params
    params.require(:event)
          .permit(:title)
          .merge(occurred_on: date_from(params[:event][:occurred_on]))
  end

  def calendar
    @_calendar ||= Calendar.find(params[:calendar_id])
  end

  def date_from(date_string)
    ArDateParser.from_date_string(date_string)
  end
end
