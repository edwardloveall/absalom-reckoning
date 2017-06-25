class CalendarsController < AuthorizedController
  def index
  end

  def show
    @calendar = Calendar.find(params[:id])
    if !current_user.can_view?(@calendar)
      flash[:notice] = I18n.t('helpers.error.calendar.not_found')
      redirect_to calendars_path
    end

    if params[:date].present?
      @date = ArDate.parse(params[:date])
    else
      @date = ArDate.new
    end

    @events = EventFilterer.new(@calendar.events_for_month(around: @date))
  end
end
