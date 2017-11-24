require 'rails_helper'

RSpec.feature 'Users sets "Today" on a calendar' do
  scenario 'sees the today marker changed' do
    user = signed_up_user
    sign_in(user)

    visit calendar_path(user.calendars.first)
    within('.week:nth-of-type(2) .day:nth-of-type(3)') do
      click_link('Set Today')
    end

    within('.week:nth-of-type(2) .day:nth-of-type(3)') do
      expect(page).to have_css('span', text: 'Today')
    end
  end
end
