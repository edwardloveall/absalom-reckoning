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
end
