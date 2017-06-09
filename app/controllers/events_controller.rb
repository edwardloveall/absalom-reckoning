class EventsController < ApplicationController
  def new
    @event = calendar.events.new
  end

  def create
    @event = calendar.events.new(event_params)

    if @event.save
      redirect_to calendar_path(calendar)
    else
      render :new
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
    else
      render :edit
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :occurred_on)
  end

  def calendar
    @_calendar ||= Calendar.find(params[:calendar_id])
  end
end
