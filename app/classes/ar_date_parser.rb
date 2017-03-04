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
    year = 0
    month = 0
    day = 0

    shift_years = 7
    day_after_leap_day = 31 + 29 + 1
    start_of_month_two = 31 + 28 + 1
    after_first_leap_day = (365 * shift_years) + day_after_leap_day
    days_into_year = 0

    if day_number >= after_first_leap_day
      leap_cycle = (365 * 8) + 1
      shift_days = day_number - after_first_leap_day
      leap_cycles = shift_days / leap_cycle
      days_since_last_leap = shift_days % leap_cycle
      days_into_year = (shift_days + start_of_month_two) % 365
      years_since_last_leap = days_since_last_leap / 365

      if days_into_year < start_of_month_two
        years_since_last_leap += 1
      end
      year = leap_cycles * 8 + years_since_last_leap + shift_years + 1
    else
      year = (day_number / 365.to_f).ceil
      days_into_year = day_number % 365
    end

    leap_year = (year % 8).zero?
    month_starts = MONTH_START_DAYS

    if leap_year
      month_starts = LEAP_YEAR_MONTH_START_DAYS
    end

    while !(days_into_year <= month_starts.values[month])
      month += 1
    end

    day = days_into_year - month_starts.values[month - 1]
    binding.pry

    ArDate.new(year: year, month: month, day: day)
  end
end
