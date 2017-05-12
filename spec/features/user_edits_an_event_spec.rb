require 'rails_helper'

RSpec.feature 'User edits an Event' do
  scenario 'by clicking on the event' do
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
end