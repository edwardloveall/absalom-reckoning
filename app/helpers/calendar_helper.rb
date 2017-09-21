module CalendarHelper
  def calendar(date, &callback)
    CalendarView.new(self, date, callback).full
  end

  def event_title_tag(calendar, event)
    if current_user.can_edit?(calendar)
      link_to event.title, edit_calendar_event_path(calendar, event)
    else
      content_tag(:span, event.title)
    end
  end

  def calendar_actions
    content_tag(:nav, class: 'calendar-actions') do
      concat link_to t('helpers.action.calendar.new'), new_calendar_path, class: 'action'
      concat link_to t('helpers.action.calendar.index'), calendars_path, class: 'action'
    end
  end
end
