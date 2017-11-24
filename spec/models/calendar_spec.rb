require 'rails_helper'

RSpec.describe Calendar do
  describe 'associations' do
    it { should have_many(:events).dependent(:destroy) }
    it { should have_many(:invitations).dependent(:destroy) }
    it { should have_many(:permissions).dependent(:destroy) }
    it { should have_many(:users).through(:permissions) }
  end

  describe 'validations' do
    it { should validate_presence_of(:current_date) }
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(100) }
  end

  describe '#last_edit_date' do
    context 'if there are events' do
      it 'returns the ArDate of the last edited event' do
        cal = create(:calendar)
        create(:event, calendar: cal, occurred_on: ArDate.parse('4710-01-01'))
        create(:event, calendar: cal, occurred_on: ArDate.parse('4712-01-01'))
        event_last = create(:event,
                            calendar: cal,
                            occurred_on: ArDate.parse('4711-01-01'))

        expect(cal.last_edit_date).to eq(event_last.occurred_on)
      end
    end

    context 'if there are no events' do
      it 'returns the default start date for an ArDate' do
        calendar = create(:calendar)

        expect(calendar.last_edit_date).to eq(ArDate.new)
      end
    end
  end

  describe '#events_for_month()' do
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

      result = calendar.events_for_month(around: date)

      expect(result).to match_array(events)
    end
  end
end
