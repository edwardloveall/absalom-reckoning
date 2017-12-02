require 'rails_helper'

RSpec.describe 'Users sets "Today" on a calendar' do
  it 'sees the today marker changed' do
    user = signed_up_user
    sign_in(user)

    visit calendar_path(user.calendars.first)
    within('.week:nth-of-type(2) .date:nth-of-type(3)') do
      click_link('Set Today')
    end

    within('.week:nth-of-type(2) .date:nth-of-type(3)') do
      expect(page).to have_css('span', text: 'Today')
    end
  end
end
