require 'rails_helper'

RSpec.feature 'User adds an Event' do
  scenario 'sees their event' do
    user = SignUpUser.perform(email: 'user@example.com', password: '12345')
    sign_in(user)

    visit calendar_path(user.calendars.first)
    within('.week:nth-of-type(2) .day:nth-of-type(3)') do
      click_link('New event')
    end

    form_params = { title: 'TPK' }
    fill_form_and_submit(:event, form_params)

    within('.week:nth-of-type(2) .day:nth-of-type(3)') do
      expect(page).to have_css('li', text: 'TPK')
    end
  end

  context 'on a different month' do
    scenario 'is taken back to to that month' do
      user = SignUpUser.perform(email: 'user@example.com', password: '12345')
      sign_in(user)

      visit calendar_path(user.calendars.first)
      click_on('next')
      within('.week:nth-of-type(2) .day:nth-of-type(3)') do
        click_link('New event')
      end

      form_params = { title: 'TPK' }
      fill_form_and_submit(:event, form_params)

      expect(page).to have_css('h2', text: 'Calistril 4711')
      within('.week:nth-of-type(2) .day:nth-of-type(3)') do
        expect(page).to have_css('li', text: 'TPK')
      end
    end
  end
end

RSpec.feature 'User tries to add an event with invalid data' do
  scenario 'sees and error' do
    user = SignUpUser.perform(email: 'user@example.com', password: '12345')
    sign_in(user)

    visit calendar_path(user.calendars.first)
    within('.week:nth-of-type(2) .day:nth-of-type(3)') do
      click_link('New event')
    end

    form_params = { title: '' }
    fill_form_and_submit(:event, form_params)

    within('.event_title') do
      expect(page).to have_css('span', text: "can't be blank")
    end
  end
end
