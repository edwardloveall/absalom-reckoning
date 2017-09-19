class CalendarPresenter < Keynote::Presenter
  presents :calendar

  def next_month_link(from:)
    link_to(
      t('helpers.action.calendar.next_month'),
      calendar_path(calendar, date: from >> 1)
    )
  end

  def previous_month_link(from:)
    link_to(
      t('helpers.action.calendar.prev_month'),
      calendar_path(calendar, date: from << 1)
    )
  end

  def month_and_year(from: date)
    month = ArDate::MONTH_NAMES[from.month - 1]
    build_html do
      h2 class: 'month-and-year' do
        "#{month} #{from.year}"
      end
    end
  end
end
