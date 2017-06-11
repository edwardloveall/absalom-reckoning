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
