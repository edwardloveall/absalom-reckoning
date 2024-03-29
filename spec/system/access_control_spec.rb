require 'rails_helper'

RSpec.describe "User can't access a calendar if they're not signed in" do
  it 'redirects the user to the homepage with a message' do
    user = signed_up_user
    calendar = user.calendars.first

    visit calendar_path(calendar)

    expect(current_path).to eq(new_session_path)
    within('.flashes') do
      expect(page).to have_css(:li, text: 'You must be logged in')
    end
  end
end

RSpec.describe "User can't access event page if they're not signed in" do
  it 'redirects the user to the homepage with a message' do
    user = signed_up_user
    calendar = user.calendars.first

    visit new_calendar_event_path(calendar)

    expect(current_path).to eq(new_session_path)
    within('.flashes') do
      expect(page).to have_css(:li, text: 'You must be logged in')
    end
  end
end

RSpec.describe "User can't see a calendar without view permissions" do
  it 'redirects the user to their calendar page with a message' do
    user = signed_up_user
    sign_in(user)
    calendar = create(:calendar)

    visit calendar_path(calendar)

    expect(current_path).to eq(not_found_path)
    expect(page).to have_css('footer', text: '404')
  end
end

RSpec.describe "User can't add event to calendar they can only view" do
  it 'redirects the user to the calendar show view with a message' do
    user = signed_up_user
    sign_in(user)
    calendar = create(:calendar)
    create(:permission, :viewer, user: user, calendar: calendar)

    visit calendar_path(calendar)
    within('.week:nth-of-type(2) .date:nth-of-type(3)') do
      expect(page).not_to have_css('a', text: 'New Event')
    end

    visit new_calendar_event_path(calendar)

    expect(current_path).to eq(root_path)
    within('.flashes') do
      message = "You don't have permission to do that"
      expect(page).to have_css(:li, text: message)
    end
  end
end

RSpec.describe "User can add event to calendar they can edit" do
  it 'shows them the event on the calendar' do
    user = signed_up_user
    sign_in(user)
    calendar = create(:calendar)
    permission = create(:permission, :editor, user: user, calendar: calendar)

    visit calendar_path(calendar)
    within('.week:nth-of-type(2) .date:nth-of-type(3)') do
      click_on 'New Event'
    end

    permission.update(level: 'viewer')
    fill_form_and_submit(:event, title: 'TPK')

    expect(current_path).to eq(root_path)
    within('.flashes') do
      message = "You don't have permission to do that"
      expect(page).to have_css(:li, text: message)
    end
  end
end

RSpec.describe "User can't edit event on calendar they can only view" do
  it 'only shows the event title' do
    user = signed_up_user
    sign_in(user)
    calendar = create(:calendar)
    event = create(:event, :visible, calendar: calendar)
    create(:permission, :viewer, user: user, calendar: calendar)

    visit calendar_path(calendar)

    expect(page).to have_css('li', text: event.title)
    expect(page).not_to have_css('a', text: event.title)
  end

  it 'redirects them back to the calendar with a message' do
    user = signed_up_user
    sign_in(user)
    calendar = create(:calendar)
    event = create(:event, calendar: calendar)
    create(:permission, :viewer, user: user, calendar: calendar)

    visit edit_calendar_event_path(calendar, event)

    expect(current_path).to eq(root_path)
    within('.flashes') do
      message = "You don't have permission to do that"
      expect(page).to have_css(:li, text: message)
    end
  end
end

RSpec.describe "User can't update event on calendar they can only view" do
  it 'redirects them back to the calendar with a message' do
    user = signed_up_user
    sign_in(user)
    calendar = create(:calendar)
    event = create(:event, :visible, calendar: calendar)
    permission = create(:permission, :editor, user: user, calendar: calendar)

    visit calendar_path(calendar)
    click_on event.title

    permission.update(level: 'viewer')

    fill_form_and_submit(:event, :update, title: 'TPK')

    expect(current_path).to eq(root_path)
    within('.flashes') do
      message = "You don't have permission to do that"
      expect(page).to have_css(:li, text: message)
    end
  end
end
