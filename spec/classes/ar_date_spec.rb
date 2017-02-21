require 'rails_helper'

RSpec.describe ArDate do
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

        expect(date.day_of_week).to eq(3)
      end
    end
  end
end
