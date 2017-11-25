require 'rails_helper'

RSpec.feature 'deletes an event' do
  scenario 'and is taken back to the calendar' do
    user = sign_in(signed_up_user)
    calendar = user.calendars.first
    date = ArDate.new(year: 4711, month: 1, day: 4)
    event = create(:event, calendar: calendar, occurred_on: date)

    visit root_path
    within('.sidebar .calendar-list') do
      click_on calendar.title
    end

    within('.week:nth-of-type(2) .date:nth-of-type(3)') do
      expect(page).to have_css('.events li', count: 1)
    end

    within('.week:nth-of-type(2) .date:nth-of-type(3)') do
      click_on event.title
    end
    click_on 'Delete'

    within('.week:nth-of-type(2) .date:nth-of-type(3)') do
      expect(page).to have_css('.events li', count: 0)
    end
  end
end
