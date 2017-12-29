namespace :dev do
  desc 'Creates sample data for local development'
  task prime: :environment do
    require 'csv'
    include ActionView::Helpers::SanitizeHelper

    user = create_user
    calendar = create_calendar(user: user)
    create_events(calendar: calendar)
  end

  def create_user
    Oath.config.sign_up_service.new(
      email: 'edward@edwardloveall.com',
      password: '12345'
    ).perform
  end

  def create_calendar(user:)
    Calendar.create(title: 'The Lord of the Rings').tap do |calendar|
      Permission.create(calendar: calendar, user: user, level: :owner)
    end
  end

  def create_events(calendar:)
    tsv_text = File.read(Rails.root.join('lib/data/lotr_events.tsv'))
    events = CSV.parse(tsv_text,
                       col_sep: "\t",
                       headers: true,
                       header_converters: :symbol)
    events.each do |event|
      date = ArDate.new(date_format(event))
      title = title_format(event[:description])
      Event.create(title: title, occurred_on: date, calendar: calendar)
    end
  end

  def date_format(event)
    string = event[:title].sub(/T.A. /, '')
    year, day_month = string.split(', ')
    year = year.to_i + 1692

    if day_month.nil?
      day_month = '1 January'
    end

    day, month = day_month.split(' ')
    day = day.to_i
    month = month_map(month)

    { year: year, month: month, day: day }
  end

  def title_format(string)
    strip_tags(string)
  end

  def month_map(month_name)
    Date::MONTHNAMES.index(month_name)
  end
end
