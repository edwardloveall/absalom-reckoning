require 'rails_helper'

RSpec.feature 'User creates a calendar' do
  scenario 'is taken to that calendar' do
    user = SignUpUser.perform(email: 'user@example.com', password: '12345')
    sign_in(user)
    title = 'Holidays'

    visit calendar_path(user.calendars.first)
    click_on('New Calendar')
    fill_form_and_submit(:calendar, title: title)

    calendar = Calendar.find_by(title: title)

    expect(current_path).to eq(calendar_path(calendar))
    expect(page).to have_css('aside li', text: title)
  end
end
