class ArDate
  include Comparable

  DAYS_INTO_WEEK = {
    moonday: 0,
    toilday: 1,
    wealday: 2,
    oathday: 3,
    fireday: 4,
    starday: 5,
    sunday: 6
  }.freeze

  DAYS_IN_MONTH = {
    abadius: 31,
    calistril: 28,
    pharast: 31,
    gozran: 30,
    desnus: 31,
    sarenith: 30,
    erastus: 31,
    arodus: 31,
    rova: 30,
    lamashan: 31,
    neth: 30,
    kuthona: 31
  }.freeze

  LEAP_YEAR_DAYS_IN_MONTH = {
    abadius: 31,
    calistril: 29,
    pharast: 31,
    gozran: 30,
    desnus: 31,
    sarenith: 30,
    erastus: 31,
    arodus: 31,
    rova: 30,
    lamashan: 31,
    neth: 30,
    kuthona: 31
  }.freeze

  attr_accessor :year, :month, :day

  def self.parse(date_string)
    ArDateParser.from_date_string(date_string)
  end

  def initialize(year: 4711, month: 1, day: 1)
    @year = year
    @month = month
    @day = day
  end

  def ==(other)
    (
      year == other.year &&
      month == other.month &&
      day == other.day
    )
  end

  def <=>(other)
    day_number <=> other.day_number
  end

  def >>(months)
    years_to_add, new_month = (month + months).divmod(12)
    new_year = year + years_to_add
    new_date = ArDate.new(year: new_year, month: new_month, day: day)

    max_month_days = days_in_month.values[new_month - 1]
    if new_date.day > max_month_days
      new_date.day = max_month_days
    end

    new_date
  end

  def <<(months)
    self.>>(-months)
  end

  def succ
    ArDateParser.from_day_number(day_number.succ)
  end

  def beginning_of_month
    ArDate.new(year: year, month: month, day: 1)
  end

  def end_of_month
    last_day = days_in_month.values[month - 1]
    ArDate.new(year: year, month: month, day: last_day)
  end

  def beginning_of_week(start_day = :moonday)
    start_day_index = DAYS_INTO_WEEK[start_day]
    days_until_next_start = (start_day_index - day_of_week + 7) % 7
    days_into_week = 7 - days_until_next_start
    new_day_number = day_number - days_into_week
    ArDateParser.from_day_number(new_day_number)
  end

  def end_of_week
    last_day_index = 6
    days_until_week_end = last_day_index - day_of_week
    new_day_number = day_number + days_until_week_end
    ArDateParser.from_day_number(new_day_number)
  end

  def day_number
    previous_year = year - 1
    days_from_years = previous_year * 365
    days_from_months = days_in_month.values.first(month - 1).reduce(0, :+)
    leap_days = previous_year / 8
    days_from_years + days_from_months + leap_days + day
  end

  def leap_year?
    (year % 8).zero?
  end

  def days_in_month
    if leap_year?
      LEAP_YEAR_DAYS_IN_MONTH
    else
      DAYS_IN_MONTH
    end
  end

  def day_of_week
    (day_number - 1) % 7
  end
end
