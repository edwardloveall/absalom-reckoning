require 'rails_helper'

RSpec.feature "User can't access a calendar if they're not signed in" do
  scenario 'redirects the user to the homepage with a message' do
    user = SignUpUser.perform(email: 'user@example.com', password: '12345')
    calendar = user.calendars.first

    visit calendar_path(calendar)

    expect(current_path).to eq(new_session_path)
    within('.flashes') do
      expect(page).to have_css(:li, text: 'You must be logged in')
    end
  end
end

RSpec.feature "User can't see a calendar with view permissions" do
  scenario 'redirects the user to their calendar page with a message' do
    user = SignUpUser.perform(email: 'user@example.com', password: '12345')
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
