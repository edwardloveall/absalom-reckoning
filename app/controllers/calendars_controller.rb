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
    @presenter.current_user = current_user

    if params[:date].present?
      @presenter.origin_date = ArDate.parse(params[:date])
    else
      @presenter.origin_date = @calendar.current_date
    end
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
    calendar = current_user.calendars.find(params[:id])
    @calendar_presenter = present(:calendar_edit, calendar)
    raise NotAuthorized if !current_user.can_own?(calendar)
    @invitation = Invitation.new(calendar: calendar, owner: current_user)
  end

  def update
    @calendar = current_user.calendars.find(params[:id])

    if @calendar.update(calendar_params)
      redirect_to calendars_path
    end
  end

  def current_date
    @calendar = current_user.calendars.find(params[:id])
    current_day_params = params.permit(:current_date)

    if @calendar.update(current_day_params)
      redirect_to calendar_path(@calendar)
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
