require 'rails_helper'

RSpec.describe EventFilterer do
  describe '#day' do
    it 'returns events on a particular day' do
      date = ArDate.new(day: 1, year: 4711, month: 1)
      event1 = create(:event, occurred_on: date)
      create(:event, occurred_on: ArDate.new(day: 5, year: 4711, month: 1))
      filter = EventFilterer.new(Event.all)

      result = filter.for(date: date)

      expect(result).to eq([event1])
    end

    context 'when multiple events are on a single day' do
      it 'returns events on a particular day' do
        date = ArDate.new(day: 1, year: 4711, month: 1)
        event1 = create(:event, occurred_on: date)
        event2 = create(:event, occurred_on: date)
        create(:event, occurred_on: ArDate.new(day: 5, year: 4711, month: 1))
        filter = EventFilterer.new(Event.all)

        result = filter.for(date: date)

        expect(result).to eq([event1, event2])
      end
    end
  end
end
