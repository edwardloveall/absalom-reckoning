class CalendarsController < AuthorizedController
  layout 'calendar', only: :show

  def index
    @calendars = Calendar.
      joins(:permissions).
      where(permissions: { level: 'owner', user: current_user })
  end

  def show
    @calendar = Calendar.find(params[:id])
    @presenter = present(@calendar)
    raise CalendarNotFound if !current_user.can_view?(@calendar)

    if params[:date].present?
      @date = ArDate.parse(params[:date])
    else
      @date = @calendar.last_edit_date
    end

    @events = EventFilterer.new(@calendar.events_for_month(around: @date))
  end

  def new
    @calendar = Calendar.new
  end

  def create
    @calendar = current_user.calendars.create(calendar_params)

    if @calendar.save
      permission = @calendar.permissions.find_by(user: current_user)
      permission.update(level: :owner)
      redirect_to calendar_path(@calendar)
    end
  end

  def edit
    @calendar = current_user.calendars.find(params[:id])
    raise NotAuthorized if !current_user.can_own?(@calendar)
    @invitation = Invitation.new(calendar: @calendar, owner: current_user)
  end

  def update
    @calendar = current_user.calendars.find(params[:id])

    if @calendar.update(calendar_params)
      redirect_to calendars_path
    end
  end

  def destroy
    @calendar = current_user.calendars.find(params[:id])

    if @calendar.destroy
      redirect_to calendars_path
    end
  end

  private

  def calendar_params
    params.require(:calendar).permit(:title)
  end
end
