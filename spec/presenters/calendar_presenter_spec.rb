require 'rails_helper'

RSpec.describe CalendarPresenter do
  describe '#next_month_link' do
    it 'returns a link to the next month' do
      calendar = create(:calendar)
      presenter = present(calendar)
      date = ArDate.new(year: 1, month: 1, day: 1)
      date_string = '1-02-01'
      html = "<a href=\"/calendars/#{calendar.id}?date=#{date_string}\">next</a>"

      result = presenter.next_month_link(from: date)

      expect(result).to eq(html)
    end
  end

  describe '#previous_month_link' do
    it 'returns a link to the previous month' do
      calendar = create(:calendar)
      presenter = present(calendar)
      date = ArDate.new(year: 1, month: 2, day: 1)
      date_string = '1-01-01'
      html = "<a href=\"/calendars/#{calendar.id}?date=#{date_string}\">previous</a>"

      result = presenter.previous_month_link(from: date)

      expect(result).to eq(html)
    end
  end

  describe '#month_and_year' do
    it 'returns the month name and year for a date' do
      calendar = create(:calendar)
      presenter = present(calendar)
      date = ArDate.new(year: 1000, month: 6, day: 20)

      html = '<h2 class="month-and-year">Sarenith 1000</h2>'

      expect(presenter.month_and_year(from: date)).to eq(html)
    end
  end
end
