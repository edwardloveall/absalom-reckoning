class EventsController < ApplicationController
  def new
    if current_user.can_edit?(calendar)
      @event = calendar.events.new
    else
      flash[:error] = I18n.t('helpers.error.no_permission')
      redirect_to calendar_path(calendar)
    end
  end

  def create
    if !current_user.can_edit?(calendar)
      flash[:error] = I18n.t('helpers.error.no_permission')
      redirect_to calendar_path(calendar)
      return
    end

    @event = calendar.events.new(event_params)

    if @event.save
      redirect_to calendar_path(calendar, date: @event.occurred_on)
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
      redirect_to calendar_path(calendar, date: @event.occurred_on)
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
