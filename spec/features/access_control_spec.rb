require 'rails_helper'

RSpec.feature "User can't access a calendar if they're not signed in" do
  scenario 'redirects the user to the homepage with a message' do
    user = signed_up_user
    calendar = user.calendars.first

    visit calendar_path(calendar)

    expect(current_path).to eq(new_session_path)
    within('.flashes') do
      expect(page).to have_css(:li, text: 'You must be logged in')
    end
  end
end

RSpec.feature "User can't access event page if they're not signed in" do
  scenario 'redirects the user to the homepage with a message' do
    user = signed_up_user
    calendar = user.calendars.first

    visit new_calendar_event_path(calendar)

    expect(current_path).to eq(new_session_path)
    within('.flashes') do
      expect(page).to have_css(:li, text: 'You must be logged in')
    end
  end
end

RSpec.feature "User can't see a calendar without view permissions" do
  scenario 'redirects the user to their calendar page with a message' do
    user = signed_up_user
    sign_in(user)
    calendar = create(:calendar)

    visit calendar_path(calendar)

    expect(current_path).to eq(calendars_path)
    within('.flashes') do
      message = "We couldn't find a calendar that you have access to"
      expect(page).to have_css(:li, text: message)
    end
  end
end

RSpec.feature "User can't add event to calendar they can only view" do
  scenario 'redirects the user to the calendar show view with a message' do
    user = signed_up_user
    sign_in(user)
    calendar = create(:calendar)
    create(:permission, :viewer, user: user, calendar: calendar)

    visit calendar_path(calendar)
    within('.week:nth-of-type(2) .day:nth-of-type(3)') do
      expect(page).not_to have_css('a', text: 'New Event')
    end

    visit new_calendar_event_path(calendar)

    expect(current_path).to eq(calendar_path(calendar))
    within('.flashes') do
      message = "You don't have permission to do that"
      expect(page).to have_css(:li, text: message)
    end
  end
end

RSpec.feature "User can't add event to calendar they can only view" do
  scenario 'redirects the user to the calendar show view with a message' do
    user = signed_up_user
    sign_in(user)
    calendar = create(:calendar)
    permission = create(:permission, :editor, user: user, calendar: calendar)

    visit calendar_path(calendar)
    within('.week:nth-of-type(2) .day:nth-of-type(3)') do
      click_on 'New event'
    end

    permission.update(level: 'viewer')
    fill_form_and_submit(:event, title: 'TPK')

    expect(current_path).to eq(calendar_path(calendar))
    within('.flashes') do
      message = "You don't have permission to do that"
      expect(page).to have_css(:li, text: message)
    end
  end
end

RSpec.feature "User can't edit event on calendar they can only view" do
  scenario 'only shows the event title' do
    user = signed_up_user
    sign_in(user)
    calendar = create(:calendar)
    event = create(:event, calendar: calendar)
    create(:permission, :viewer, user: user, calendar: calendar)

    visit calendar_path(calendar)

    expect(page).to have_css('li', text: event.title)
    expect(page).not_to have_css('a', text: event.title)
  end

  scenario 'redirects them back to the calendar with a message' do
    user = signed_up_user
    sign_in(user)
    calendar = create(:calendar)
    event = create(:event, calendar: calendar)
    create(:permission, :viewer, user: user, calendar: calendar)

    visit edit_calendar_event_path(calendar, event)

    expect(current_path).to eq(calendar_path(calendar))
    within('.flashes') do
      message = "You don't have permission to do that"
      expect(page).to have_css(:li, text: message)
    end
  end
end

RSpec.feature "User can't update event on calendar they can only view" do
  scenario 'redirects them back to the calendar with a message' do
    user = signed_up_user
    sign_in(user)
    calendar = create(:calendar)
    event = create(:event, calendar: calendar)
    permission = create(:permission, :editor, user: user, calendar: calendar)

    visit calendar_path(calendar)
    click_on event.title

    permission.update(level: 'viewer')

    fill_form_and_submit(:event, :update, title: 'TPK')

    expect(current_path).to eq(calendar_path(calendar))
    within('.flashes') do
      message = "You don't have permission to do that"
      expect(page).to have_css(:li, text: message)
    end
  end
end
