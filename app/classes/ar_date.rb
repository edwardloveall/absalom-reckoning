class ArDate
  DAYS_INTO_WEEK = {
    moonday: 0,
    toilday: 1,
    wealday: 2,
    oathday: 3,
    fireday: 4,
    starday: 5,
    sunday: 6
  }

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
  }

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
  }

  attr_accessor :year, :month, :day

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

  def beginning_of_month
    ArDate.new(year: year, month: month, day: 1)
  end

  def end_of_month
    last_day = DAYS_IN_MONTH.values[month - 1]
    ArDate.new(year: year, month: month, day: last_day)
  end

  def day_number
    @_day_number ||= begin
      previous_year = year - 1
      days_from_years = previous_year * 365
      days_from_months = days_in_month.values.first(month - 1).reduce(0, :+)
      leap_days = previous_year / 8
      days_from_years + days_from_months + leap_days + day
    end
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
