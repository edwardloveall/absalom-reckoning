require 'rails_helper'

RSpec.describe ArDate do
  describe '.parse' do
    it 'calls ArDateParser.from_date_string' do
      allow(ArDateParser).to receive(:from_date_string)

      ArDate.parse('3000/4/17')

      expect(ArDateParser).to have_received(:from_date_string)
    end
  end

  describe '#initialize' do
    context 'when no parameters are given' do
      it 'sets the default year, month, and day' do
        date = ArDate.new

        expect(date.year).to eq(4711)
        expect(date.month).to eq(1)
        expect(date.day).to eq(1)
      end
    end

    it 'sets the year, month, and day' do
      date = ArDate.new(year: 4707, month: 9, day: 23)

      expect(date.year).to eq(4707)
      expect(date.month).to eq(9)
      expect(date.day).to eq(23)
    end
  end

  describe '#<=>' do
    it 'returns -1 when date is less than the other date' do
      smaller_date = ArDate.new(year: 1, month: 12, day: 17)
      larger_date = ArDate.new(year: 3, month: 2, day: 12)

      result = smaller_date <=> larger_date

      expect(result).to eq(-1)
    end

    it 'returns 0 when date is equal to the other date' do
      first_date = ArDate.new(year: 2, month: 5, day: 21)
      second_date = ArDate.new(year: 2, month: 5, day: 21)

      result = first_date <=> second_date

      expect(result).to eq(0)
    end

    it 'returns 1 when date is greater than the other date' do
      larger_date = ArDate.new(year: 4711, month: 1, day: 1)
      smaller_date = ArDate.new(year: 3, month: 2, day: 12)

      result = larger_date <=> smaller_date

      expect(result).to eq(1)
    end
  end

  describe '#>>' do
    it 'returns the same date one month later' do
      now = ArDate.new(year: 1, month: 1, day: 1)
      next_month = ArDate.new(year: 1, month: 2, day: 1)

      result = now >> 1

      expect(result).to eq(next_month)
    end

    context 'when the month math spans multiple months' do
      it 'returns a date some months later' do
        now = ArDate.new(year: 1, month: 1, day: 1)
        next_month = ArDate.new(year: 1, month: 3, day: 1)

        result = now >> 2

        expect(result).to eq(next_month)
      end
    end

    context 'when the month math spans multiple years' do
      it 'returns a date some months later' do
        now = ArDate.new(year: 1, month: 1, day: 7)
        next_month = ArDate.new(year: 2, month: 2, day: 7)

        result = now >> 13

        expect(result).to eq(next_month)
      end
    end

    context 'when the day is an invalid day for the resulting month' do
      it 'returns a date some months later' do
        now = ArDate.new(year: 1, month: 1, day: 31)
        next_month = ArDate.new(year: 1, month: 2, day: 28)

        result = now >> 1

        expect(result).to eq(next_month)
      end
    end
  end

  describe '#<<' do
    it 'returns the same date one month earlier' do
      now = ArDate.new(year: 1, month: 2, day: 1)
      prev_month = ArDate.new(year: 1, month: 1, day: 1)

      result = now << 1

      expect(result).to eq(prev_month)
    end

    context 'when the month math spans multiple months' do
      it 'returns a date some months before' do
        now = ArDate.new(year: 1, month: 3, day: 1)
        prev_month = ArDate.new(year: 1, month: 1, day: 1)

        result = now << 2

        expect(result).to eq(prev_month)
      end
    end

    context 'when the month math spans multiple years' do
      it 'returns a date some months before' do
        now = ArDate.new(year: 2, month: 3, day: 7)
        prev_month = ArDate.new(year: 1, month: 1, day: 7)

        result = now << 14

        expect(result).to eq(prev_month)
      end
    end

    context 'when the day is an invalid day for the resulting month' do
      it 'returns a date some months before' do
        now = ArDate.new(year: 1, month: 5, day: 31)
        prev_month = ArDate.new(year: 1, month: 4, day: 30)

        result = now << 1

        expect(result).to eq(prev_month)
      end
    end
  end

  describe '#succ' do
    it 'returns an ArDate on the next day' do
      start_date = ArDate.new(year: 10, month: 5, day: 2)
      end_date = ArDate.new(year: 10, month: 5, day: 3)

      expect(start_date.succ).to eq(end_date)
    end

    context 'when the next day is after a leap day' do
      it 'returns an ArDate on the next day' do
        start_date = ArDate.new(year: 8, month: 2, day: 29)
        end_date = ArDate.new(year: 8, month: 3, day: 1)

        expect(start_date.succ).to eq(end_date)
      end
    end

    context 'when the next day is in the new year' do
      it 'returns an ArDate on the next day' do
        start_date = ArDate.new(year: 17, month: 12, day: 31)
        end_date = ArDate.new(year: 18, month: 1, day: 1)

        expect(start_date.succ).to eq(end_date)
      end
    end
  end

  describe '#begining_of_month' do
    it 'returns the date at the first day of the month' do
      date = ArDate.new(year: 4707, month: 9, day: 23)
      month_start = ArDate.new(year: 4707, month: 9, day: 1)

      expect(date.beginning_of_month).to eq(month_start)
    end
  end

  describe '#end_of_month' do
    it 'returns the date at the last day of the month' do
      date = ArDate.new(year: 4707, month: 9, day: 23)
      month_end = ArDate.new(year: 4707, month: 9, day: 30)

      expect(date.end_of_month).to eq(month_end)
    end

    context 'when in a leap month' do
      it 'returns the date at the last day of the month' do
        date = ArDate.new(year: 8, month: 2, day: 20)
        month_end = ArDate.new(year: 8, month: 2, day: 29)

        expect(date.end_of_month).to eq(month_end)
      end
    end
  end

  describe '#beginning_of_week' do
    it 'returns a date at the beginning of the current week' do
      date = ArDate.new(year: 1, month: 1, day: 5)
      week_start = ArDate.new(year: 1, month: 1, day: 1)

      expect(date.beginning_of_week).to eq(week_start)
    end

    context 'when the start of the week is in the previous month' do
      it 'returns a date at the beginning of the current week' do
        date = ArDate.new(year: 1, month: 2, day: 1)
        week_start = ArDate.new(year: 1, month: 1, day: 29)

        expect(date.beginning_of_week).to eq(week_start)
      end
    end

    context 'when an argument for the week start day is given' do
      it 'returns a date at that start day' do
        date = ArDate.new(year: 1, month: 2, day: 1)
        week_start = ArDate.new(year: 1, month: 1, day: 28)

        result = date.beginning_of_week(:sunday)

        expect(result).to eq(week_start)
      end
    end
  end

  describe '#end_of_week' do
    it 'returns a date at the end of the current week' do
      date = ArDate.new(year: 1, month: 1, day: 5)
      week_end = ArDate.new(year: 1, month: 1, day: 7)

      expect(date.end_of_week).to eq(week_end)
    end

    context 'when the end of the week is in the next month' do
      it 'returns a date at the end of the current week' do
        date = ArDate.new(year: 1, month: 1, day: 31)
        week_end = ArDate.new(year: 1, month: 2, day: 4)

        expect(date.end_of_week).to eq(week_end)
      end
    end
  end

  describe '#day_number' do
    it 'returns the day number for 1/1/1' do
      date = ArDate.new(year: 1, month: 1, day: 1)

      expect(date.day_number).to eq(1)
    end

    it 'returns the day number for 1/1/9' do
      date = ArDate.new(year: 9, month: 1, day: 1)

      expect(date.day_number).to eq(2922)
    end

    it 'returns the day number for 9/23/4711' do
      date = ArDate.new(year: 4711, month: 9, day: 23)

      expect(date.day_number).to eq(1_720_004)
    end
  end

  describe '#day_of_week' do
    it 'returns an integer for the day of the week of a given day' do
      date = ArDate.new(year: 1)

      expect(date.day_of_week).to eq(0)
    end

    context 'when the day is later in the month' do
      it 'returns an integer for the day of the week of a given day' do
        date = ArDate.new(year: 1, day: 23)

        expect(date.day_of_week).to eq(1)
      end
    end

    context 'when the day is many months in' do
      it 'returns an integer for the day of the week of a given day' do
        date = ArDate.new(year: 1, month: 9, day: 23)

        expect(date.day_of_week).to eq(6)
      end
    end

    context 'when the day is many years in' do
      it 'returns an integer for the day of the week of a given day' do
        date = ArDate.new(year: 5, month: 9, day: 23)

        expect(date.day_of_week).to eq(3)
      end
    end

    context 'when the day is past a leap year' do
      it 'returns an integer for the day of the week of a given day' do
        date = ArDate.new(year: 10, month: 9, day: 23)

        expect(date.day_of_week).to eq(2)
      end
    end

    context 'the day is in a leap year but the leap day has not happened' do
      it 'returns an integer for the day of the week of a given day' do
        date = ArDate.new(year: 8, month: 1, day: 23)

        expect(date.day_of_week).to eq(1)
      end
    end
  end
end
