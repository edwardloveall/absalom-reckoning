require 'rails_helper'

RSpec.feature 'Users signs out' do
  scenario 'sees sign in link' do
    user = SignUpUser.perform(email: 'user@example.com', password: '12345')
    sign_in(user)

    visit calendar_path(user.calendars.first)
    click_on 'Sign out'

    expect(page).to have_css('a', text: 'Sign in')
  end
end
