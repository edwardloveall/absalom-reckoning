require 'rails_helper'

RSpec.feature 'User adds an Event' do
  scenario 'by clicking on a day' do
    user = SignUpUser.perform(email: 'user@example.com', password: '12345')
    sign_in(user)

    visit calendar_path(user.calendars.first)
    within('.week:nth-of-type(2) .day:nth-of-type(3)') do
      click_link('New event')
    end

    form_params = { title: 'TPK' }
    fill_form_and_submit(:event, form_params)

    expect(page).to have_css('li', text: 'TPK')
  end
end
