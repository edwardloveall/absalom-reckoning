module CalendarHelper
  def calendar(date, events)
    CalendarView.new(self, date, events).full
  end
end
