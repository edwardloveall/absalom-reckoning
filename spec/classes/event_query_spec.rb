require 'rails_helper'

RSpec.describe EventQuery do
  describe '#visible_to' do
    context 'if the user is an owner' do
      it 'returns all events' do
        owner = signed_up_user
        calendar = owner.calendars.first
        events = [
          create(:event, :hidden, calendar: calendar),
          create(:event, :visible, calendar: calendar)
        ]

        result = EventQuery.visible_to(owner, from: calendar)

        expect(result).to match_array(events)
      end
    end

    context 'if the user is an editor' do
      it 'returns visible events' do
        editor = signed_up_user
        permission = create(:permission, :editor, user: editor)
        calendar = permission.calendar
        create(:event, :hidden, calendar: calendar)
        events = [create(:event, :not_hidden, calendar: calendar)]

        result = EventQuery.visible_to(editor, from: calendar)

        expect(result).to match_array(events)
      end
    end
  end
end
