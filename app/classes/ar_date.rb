class ArDate
  include Comparable

  DAY_NAMES = [:moonday, :toilday, :wealday, :oathday,
               :fireday, :starday, :sunday].freeze
  MONTH_LENGTHS = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31].freeze
  LEAP_MONTH_LENGTHS = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31].freeze
  MONTH_NAMES = %w(Abadius Calistril Pharast Gozran Desnus Sarenith Erastus
                   Arodus Rova Lamashan Neth Kuthona).freeze
  attr_accessor :year, :month, :day

  def self.parse(date_string)
    ArDateParser.from_date_string(date_string)
  end

  def initialize(year: 4711, month: 1, day: 1)
    @year = year
    @month = month
    @day = day
  end

  def to_s
    month_string = month.to_s.rjust(2, '0')
    day_string = day.to_s.rjust(2, '0')
    "#{year}-#{month_string}-#{day_string}"
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
    month_positions = (1..12).to_a
    years_to_add, month_index = (month - 1 + months).divmod(12)
    new_month = month_positions[month_index]
    new_year = year + years_to_add
    new_date = ArDate.new(year: new_year, month: new_month, day: day)

    max_month_days = days_in_month[new_month - 1]
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
    last_day = days_in_month[month - 1]
    ArDate.new(year: year, month: month, day: last_day)
  end

  def beginning_of_week(start_day = :moonday)
    start_day_index = DAY_NAMES.index(start_day)
    days_into_week = (day_of_week - start_day_index) % DAY_NAMES.length
    new_day_number = day_number - days_into_week
    ArDateParser.from_day_number(new_day_number)
  end

  def end_of_week(start_day = :moonday)
    last_day_index = (DAY_NAMES.index(start_day) - 1) % DAY_NAMES.length
    until_last_day = (last_day_index - day_of_week) % DAY_NAMES.length
    new_day_number = day_number + until_last_day
    ArDateParser.from_day_number(new_day_number)
  end

  def day_number
    previous_year = year - 1
    days_from_years = previous_year * 365
    days_from_months = days_in_month.first(month - 1).reduce(0, :+)
    leap_days = previous_year / 8
    days_from_years + days_from_months + leap_days + day
  end

  def leap_year?
    (year % 8).zero?
  end

  def days_in_month
    if leap_year?
      LEAP_MONTH_LENGTHS
    else
      MONTH_LENGTHS
    end
  end

  def day_of_week
    (day_number - 1) % 7
  end
end
