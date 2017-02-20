class CalendarView
  HEADER = %w(Sunday Monday Tuesday Wednesday Thursday Friday Saturday).freeze
  START_DAY = :sunday

  delegate :content_tag, to: :view
  attr_reader :view, :date, :callback

  def initialize(view, date, callback)
    @view = view
    @date = date
    @callback = callback
  end

  def full
    content_tag :div, class: 'wrapper' do
      header + week_rows
    end
  end

  def header
    content_tag :header do
      HEADER.map { |day| content_tag :div, day }.join.html_safe
    end
  end

  def week_rows
    weeks.map do |week|
      content_tag :div, class: 'week' do
        week.map { |day| day_cell(day) }.join.html_safe
      end
    end.join.html_safe
  end

  def day_cell(day)
    content_tag :div, view.capture(day, &callback), class: day_classes(day)
  end

  def day_classes(day)
    classes = ['day']
    classes << 'today' if day == Date.today
    classes << 'not-month' if day.month != date.month
    classes.empty? ? nil : classes.join(' ')
  end

  def weeks
    first = date.beginning_of_month.beginning_of_week(START_DAY)
    last = date.end_of_month.end_of_week(START_DAY)
    (first..last).to_a.in_groups_of(7)
  end
end
