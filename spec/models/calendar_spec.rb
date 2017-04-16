require 'rails_helper'

RSpec.describe Calendar do
  describe 'associations' do
    it { should have_many(:events) }
  end

  describe '.events_for_month()' do
    it 'returns events based on an input date for a calendar' do
      date = ArDate.new(year: 4711, month: 1, day: 1)
      calendar = create(:calendar)
      non_date = ArDate.new(year: 4711, month: 5, day: 1)
      before_date = ArDate.new(year: 4710, month: 12, day: 31)
      during_date = ArDate.new(year: 4711, month: 1, day: 15)
      after_date = ArDate.new(year: 4711, month: 2, day: 1)
      create(:event, occurred_on: non_date, calendar: calendar)
      before = create(:event, occurred_on: before_date, calendar: calendar)
      during = create(:event, occurred_on: during_date, calendar: calendar)
      after = create(:event, occurred_on: after_date, calendar: calendar)
      events = [before, during, after]

      result = Calendar.events_for_month(around: date)

      expect(events).to match_array(result)
    end
  end
end
