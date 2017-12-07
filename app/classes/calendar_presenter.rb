class CalendarPresenter < Keynote::Presenter
  presents :calendar
  use_html_5_tags

  attr_accessor :origin_date, :current_user

  START_DAY = :moonday

  def next_month_link
    link_to(
      t('helpers.action.calendar.next_month'),
      calendar_path(calendar, date: origin_date >> 1),
      class: 'next'
    )
  end

  def previous_month_link
    link_to(
      t('helpers.action.calendar.prev_month'),
      calendar_path(calendar, date: origin_date << 1),
      class: 'previous'
    )
  end

  def month_and_year
    month = ArDate::MONTH_NAMES[origin_date.month - 1]
    build_html do
      h2 class: 'month-and-year' do
        "#{month} #{origin_date.year}"
      end
    end
  end

  def day_names_header
    build_html do
      header do
        ArDate::DAY_NAMES.each do |day|
          div day.capitalize
        end
      end
    end
  end

  def calendar_weeks
    weeks.each do |week|
      yield week
    end
  end

  def week_dates(within:)
    week = within
    week.each do |date|
      yield date
    end
  end

  def date_classes(date)
    classes = %w(date)
    classes << 'today' if date == calendar.current_date
    classes << 'not-month' if date.month != origin_date.month
    classes.join(' ')
  end

  def today_action(on:)
    date = on
    if date == calendar.current_date
      build_html { span.today t('titles.current_day') }
    elsif editor?
      link_to(
        t('helpers.action.calendar.set_today'),
        current_date_calendar_path(@calendar, current_date: date),
        method: :patch,
        class: 'set-today'
      )
    end
  end

  def events(on:)
    date = on
    events = calendar.events.where(event_conditions(date))
    build_html do
      ul.events do
        if !events.empty?
          events.each do |event|
            li do
              if editor?
                link_to event.title, edit_calendar_event_path(calendar, event)
              else
                span event.title
              end
            end
          end
        end
      end
    end
  end

  def new_event_action(on:)
    date = on
    if editor?
      build_html do
        a(
          t('helpers.action.event.new'),
          href: new_calendar_event_path(calendar, occurred_on: date.day_number),
          class: 'new-event'
        )
      end
    end
  end

  private

  def weeks
    first = origin_date.beginning_of_month.beginning_of_week(START_DAY)
    last = origin_date.end_of_month.end_of_week(START_DAY)
    (first..last).to_a.in_groups_of(7)
  end

  def editor?
    if defined?(current_user)
      current_user.can_edit?(calendar)
    else
      false
    end
  end

  def event_conditions(date)
    conditions = { occurred_on: date }
    if !current_user.can_own?(calendar)
      conditions[:hidden_at] = nil
    end
    conditions
  end
end
