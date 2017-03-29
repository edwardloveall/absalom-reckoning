require 'rails_helper'

RSpec.describe ArDateParser do
  describe '.from_day_number' do
    it 'returns an ArDate from the day number' do
      day = 1
      date = ArDate.new(year: 1, month: 1, day: 1)

      parsed_date = ArDateParser.from_day_number(day)

      expect(parsed_date).to eq(date)
    end

    context 'when the day in a few years in' do
      it 'returns an ArDate from the day number' do
        day = 1920
        date = ArDate.new(year: 6, month: 4, day: 5)

        parsed_date = ArDateParser.from_day_number(day)

        expect(parsed_date).to eq(date)
      end
    end

    context 'when the day is after a leap day' do
      it 'returns an ArDate from the day number' do
        day = 3719
        date = ArDate.new(year: 11, month: 3, day: 9)

        parsed_date = ArDateParser.from_day_number(day)

        expect(parsed_date).to eq(date)
      end
    end

    context 'when the day is on the leap day' do
      it 'returns an ArDate from the day number' do
        day = 2615
        date = ArDate.new(year: 8, month: 2, day: 29)

        parsed_date = ArDateParser.from_day_number(day)

        expect(parsed_date).to eq(date)
      end
    end

    context 'when the day is just after a leap day' do
      it 'returns an ArDate from the day number' do
        day = 2616
        date = ArDate.new(year: 8, month: 3, day: 1)

        parsed_date = ArDateParser.from_day_number(day)

        expect(parsed_date).to eq(date)
      end
    end

    context 'when the day is after two leap days' do
      it 'returns an ArDate from the day number' do
        day = 7079
        date = ArDate.new(year: 20, month: 5, day: 22)

        parsed_date = ArDateParser.from_day_number(day)

        expect(parsed_date).to eq(date)
      end

      context 'but before the third month in the year' do
        it 'returns an ArDate from the day number' do
          day = 6938
          date = ArDate.new(year: 20, month: 1, day: 1)

          parsed_date = ArDateParser.from_day_number(day)

          expect(parsed_date).to eq(date)
        end
      end
    end

    context 'when a day is in the last month of the year' do
      it 'returns an ArDate from the day number' do
        day = 349
        date = ArDate.new(year: 1, month: 12, day: 15)

        parsed_date = ArDateParser.from_day_number(day)

        expect(parsed_date).to eq(date)
      end
    end
  end

  describe '.from_date_string' do
    it 'returns a date from the format YYYY-MM-DD' do
      target_date = ArDate.new(year: 3000, month: 4, day: 17)

      date = ArDateParser.from_date_string('3000-04-17')

      expect(date).to eq(target_date)
    end
  end
end
