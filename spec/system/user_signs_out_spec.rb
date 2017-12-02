require 'rails_helper'

RSpec.describe 'Users signs out' do
  it 'sees sign in link' do
    user = signed_up_user
    sign_in(user)

    visit calendar_path(user.calendars.first)
    click_on 'Sign out'

    expect(page).to have_css('a', text: 'Sign in')
  end
end
