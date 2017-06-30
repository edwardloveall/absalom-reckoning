require 'rails_helper'

RSpec.feature 'User navigates to a calendar' do
  scenario 'by clicking links in the sidebar' do
    user = SignUpUser.perform(email: 'user@example.com', password: '12345')
    sign_in(user)
    calendar = create(:calendar)
    create(:permission, :owner, user: user, calendar: calendar)

    visit calendars_path
    click_on calendar.title

    expect(current_path).to eq(calendar_path(calendar))
  end
end
