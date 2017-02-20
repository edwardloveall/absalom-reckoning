module CalendarHelper
  def calendar(date = Date.today, &block)
    CalendarView.new(self, date, block).full
  end
end
