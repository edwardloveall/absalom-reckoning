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
end
