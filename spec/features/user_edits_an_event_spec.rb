require 'rails_helper'

RSpec.feature 'User edits an Event' do
  scenario 'sees their changes' do
    user = SignUpUser.perform(email: 'user@example.com', password: '12345')
    sign_in(user)
    date = ArDate.new(year: 4711, month: 1, day: 4)
    event = create(:event, calendar: user.calendars.first, occurred_on: date)

    visit calendar_path(user.calendars.first)
    click_link(event.title)

    form_params = { title: 'A new title' }
    fill_form_and_submit(:event, :update, form_params)

    expect(page).to have_css('li', text: 'A new title')
  end

  context 'in a different month' do
    scenario 'sees their changes' do
      user = SignUpUser.perform(email: 'user@example.com', password: '12345')
      sign_in(user)
      date = ArDate.new(year: 4711, month: 2, day: 15)
      event = create(:event, calendar: user.calendars.first, occurred_on: date)

      visit calendar_path(user.calendars.first)
      click_on('next')
      click_on(event.title)

      form_params = { title: 'A new title' }
      fill_form_and_submit(:event, :update, form_params)

      expect(page).to have_css('h2', text: 'Calistril 4711')
      expect(page).to have_css('li', text: 'A new title')
    end
  end
end

RSpec.feature 'User tries to edit an Event with invalid data' do
  scenario 'sees and error' do
    user = SignUpUser.perform(email: 'user@example.com', password: '12345')
    sign_in(user)
    date = ArDate.new(year: 4711, month: 1, day: 4)
    event = create(:event, calendar: user.calendars.first, occurred_on: date)

    visit calendar_path(user.calendars.first)
    click_link(event.title)

    form_params = { title: '' }
    fill_form_and_submit(:event, :update, form_params)

    within('.event_title') do
      expect(page).to have_css('span', text: "can't be blank")
    end
  end
end
