class EventsController < AuthorizedController
  def new
    raise NotAuthorized if !current_user.can_edit?(calendar)
    @event = calendar.events.new
  end

  def create
    raise NotAuthorized if !current_user.can_edit?(calendar)

    @event = calendar.events.new(event_params)

    if @event.save
      redirect_to calendar_path(calendar, date: @event.occurred_on)
    else
      render :new
    end
  end

  def edit
    raise NotAuthorized if !current_user.can_edit?(calendar)

    @calendar = calendar
    @event = @calendar.events.find(params[:id])
  end

  def update
    raise NotAuthorized if !current_user.can_edit?(calendar)

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
    date = params[:event].delete(:occurred_on)
    if !date.nil?
      params[:event][:occurred_on] = ArDate.parse(date).day_number
    end
    params.require(:event).permit(:title, :occurred_on)
  end

  def calendar
    @_calendar ||= Calendar.find(params[:calendar_id])
  end
end
