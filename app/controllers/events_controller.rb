class EventsController < AuthorizedController
  def new
    require_calendar_edit_access
    @event = calendar.events.new
  end

  def create
    require_calendar_edit_access
    @event = calendar.events.new(event_params)

    if @event.save
      redirect_to calendar_path(calendar, date: @event.occurred_on)
    else
      render :new
    end
  end

  def edit
    require_calendar_edit_access
    @calendar = calendar
    @event = @calendar.events.find(params[:id])
  end

  def update
    require_calendar_edit_access
    @calendar = calendar
    @event = @calendar.events.find(params[:id])

    if @event.update(event_params)
      redirect_to calendar_path(calendar, date: @event.occurred_on)
    else
      render :edit
    end
  end

  def destroy
    require_calendar_edit_access
    @calendar = calendar
    @event = @calendar.events.find(params[:id])

    if @event.destroy
      redirect_to calendar_path(calendar, date: @event.occurred_on)
    else
      render :edit
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :occurred_on, :hidden)
  end

  def calendar
    @_calendar ||= Calendar.find(params[:calendar_id])
  end

  def require_calendar_edit_access
    raise NotAuthorized if !current_user.can_edit?(calendar)
  end
end
