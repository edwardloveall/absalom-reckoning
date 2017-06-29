class CalendarsController < AuthorizedController
  def index
  end

  def show
    @calendar = Calendar.find(params[:id])
    raise CalendarNotFound if !current_user.can_view?(@calendar)

    if params[:date].present?
      @date = ArDate.parse(params[:date])
    else
      @date = ArDate.new
    end

    @events = EventFilterer.new(@calendar.events_for_month(around: @date))
  end
end
