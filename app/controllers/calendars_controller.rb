class CalendarsController < AuthorizedController
  def index
  end

  def show
    @calendar = Calendar.find(params[:id])
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
      redirect_to calendar_path(@calendar)
    end
  end

  private

  def calendar_params
    params.require(:calendar).permit(:title)
  end
end
