class ArDateParser
  MONTH_START_DAYS = {
    abadius: 0,
    calistril: 31,
    pharast: 59,
    gozran: 90,
    desnus: 120,
    sarenith: 151,
    erastus: 181,
    arodus: 212,
    rova: 243,
    lamashan: 273,
    neth: 304,
    kuthona: 334
  }.freeze

  LEAP_YEAR_MONTH_START_DAYS = {
    abadius: 0,
    calistril: 31,
    pharast: 60,
    gozran: 91,
    desnus: 121,
    sarenith: 152,
    erastus: 182,
    arodus: 213,
    rova: 244,
    lamashan: 274,
    neth: 305,
    kuthona: 335
  }.freeze

  def self.from_day_number(day_number)
    days_in_year = 365
    fractional_leap_day = 1/8.to_f
    average_days_in_year = days_in_year + fractional_leap_day

    year = (day_number / average_days_in_year).ceil
    previous_year = year - 1

    leap_days_before_year = previous_year / 8
    days_before_year = 365 * previous_year + leap_days_before_year
    days_into_year = day_number - days_before_year

    leap_year = (year % 8).zero?
    month_starts = MONTH_START_DAYS

    if leap_year
      month_starts = LEAP_YEAR_MONTH_START_DAYS
    end

    month = 0
    while !(days_into_year <= month_starts.values[month])
      month += 1
    end

    month_index = month - 1
    day = days_into_year - month_starts.values[month_index]

    ArDate.new(year: year, month: month, day: day)
  end
end
