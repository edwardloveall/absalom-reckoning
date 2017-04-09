module CalendarHelper
  def calendar(date, &callback)
    CalendarView.new(self, date, callback).full
  end
end
