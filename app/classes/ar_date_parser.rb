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

  DATE_FORMATS = {
    year_month_day: /\d+\W\d+\W\d+/
  }.freeze

  class DateFormatNotFound < StandardError; end

  def self.from_day_number(day_number)
    new.from_day_number(day_number)
  end

  def from_day_number(day_number)
    @day_number = day_number
    ArDate.new(year: year, month: month, day: day)
  end

  def self.from_date_string(date_string)
    new.from_date_string(date_string)
  end

  def from_date_string(date_string)
    DATE_FORMATS.each do |method, regex|
      if date_string.match(regex)
        return send(method, date_string)
      end
    end
    raise DateFormatNotFound
  end

  private

  attr_reader :day_number

  def year
    @_year || begin
      days_in_year = 365
      fractional_leap_day = 1 / 8.to_f
      average_days_in_year = days_in_year + fractional_leap_day

      (day_number / average_days_in_year).ceil
    end
  end

  def days_into_year
    @_days_into_year ||= begin
      previous_year = year - 1

      leap_days_before_year = previous_year / 8
      days_before_year = 365 * previous_year + leap_days_before_year
      day_number - days_before_year
    end
  end

  def leap_year?
    (year % 8).zero?
  end

  def month_starts
    if leap_year?
      LEAP_YEAR_MONTH_START_DAYS
    else
      MONTH_START_DAYS
    end
  end

  def month
    @_month ||= begin
      included_months = month_starts.select do |_, start|
        start < days_into_year
      end
      included_months.count
    end
  end

  def day
    @_day ||= begin
      month_index = month - 1
      days_into_year - month_starts.values[month_index]
    end
  end

  def year_month_day(date_string)
    scanner = StringScanner.new(date_string)

    year = scanner.scan(/\d+/).to_i
    scanner.skip(/\W/)
    month = scanner.scan(/\d+/).to_i
    scanner.skip(/\W/)
    day = scanner.scan(/\d+/).to_i

    ArDate.new(year: year, month: month, day: day)
  end
end
