class CalendarView
  HEADER = ArDate::DAY_NAMES
  START_DAY = :moonday

  delegate :content_tag, to: :view
  attr_reader :view, :date, :events

  def initialize(view, date, events)
    @view = view
    @date = date
    @events = events
  end

  def full
    content_tag :div, class: 'wrapper' do
      header + week_rows
    end
  end

  def header
    content_tag :header do
      HEADER.map { |day| content_tag :div, day.capitalize }.join.html_safe
    end
  end

  def week_rows
    weeks.map do |week|
      content_tag :div, class: 'week' do
        week.map { |day| day_cell(day) }.join.html_safe
      end
    end.join.html_safe
  end

  def weeks
    first = date.beginning_of_month.beginning_of_week(START_DAY)
    last = date.end_of_month.end_of_week(START_DAY)
    (first..last).to_a.in_groups_of(7)
  end

  def day_cell(day)
    content_tag :div, class: day_classes(day) do
      view.concat(day.day)
      view.concat(event_list(day))
    end
  end

  def day_classes(day)
    classes = ['day']
    classes << 'today' if day == ArDate.new
    classes << 'not-month' if day.month != date.month
    classes.empty? ? nil : classes.join(' ')
  end

  def day_header(day)
    content_tag(day.day)
  end

  def event_list(day)
    events_for_day = events.select { |event| event.occurred_on == day }

    view.capture do
      content_tag(:ul) do
        events_for_day.each do |event|
          view.concat(content_tag(:li, event.title))
        end
      end
    end
  end
end
