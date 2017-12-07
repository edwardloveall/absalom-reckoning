require 'rails_helper'

RSpec.describe Event do
  describe 'attributes' do
    describe 'occurred_on' do
      it 'converts from a Fixnum to an ArDate on assignment' do
        days = 12_345
        date = ArDateParser.from_day_number(days)

        event = Event.new(occurred_on: days)

        expect(event.occurred_on).to eq(date)
      end

      it 'serializes the ArDate into a Fixnum' do
        days = 12_345
        date = ArDateParser.from_day_number(days)
        event = create(:event, occurred_on: date)

        value = event.attributes_before_type_cast['occurred_on']

        expect(value).to eq(days)
      end

      it 'deserializes the Fixnum into an ArDate' do
        event = create(:event)

        expect(event.occurred_on).to be_an(ArDate)
      end
    end
  end

  describe 'associations' do
    it { should belong_to(:calendar) }
  end

  describe 'validations' do
    it { should validate_presence_of(:occurred_on) }
    it { should validate_presence_of(:title) }
  end

  describe '#hidden' do
    it 'returns true if hidden_at is set' do
      event = Event.new(hidden_at: Time.current)

      expect(event).to be_hidden
    end

    it 'returns false if hidden_at is not set' do
      event = Event.new(hidden_at: nil)

      expect(event).not_to be_hidden
    end
  end

  describe '.visible' do
    it 'returns all not hidden events' do
      visible = [create(:event, :not_hidden)]
      create(:event, :hidden)

      events = Event.visible

      expect(events).to match_array(visible)
    end
  end
end
