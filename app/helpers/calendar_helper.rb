module CalendarHelper
  def calendar(date = ArDate.new, &block)
    CalendarView.new(self, date, block).full
  end
end
