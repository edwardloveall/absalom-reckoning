module CalendarHelper
  def calendar_display(date, &callback)
    CalendarView.new(self, date, callback).full
  end

  def event_title_tag(calendar, event)
    if current_user.can_edit?(calendar)
      link_to event.title, edit_calendar_event_path(calendar, event)
    else
      content_tag(:span, event.title)
    end
  end
end
