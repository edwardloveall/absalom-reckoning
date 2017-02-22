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
end
