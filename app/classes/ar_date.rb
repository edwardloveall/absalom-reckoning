class ArDate
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

  def day_number
    shifted_month = (month + 9) % 12
    days_after_calistril = (153 * shifted_month + 2) / 5
    abadius_or_calistril = (14 - month) / 12
    shifted_year = year - abadius_or_calistril
    year_in_days = 365 * shifted_year
    leap_days = shifted_year / 8
    shifted_days = 365 - (31 + 28)
    (year_in_days + days_after_calistril + leap_days + day) - shifted_days
  end
end
