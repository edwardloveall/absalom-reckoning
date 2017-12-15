require 'rails_helper'

RSpec.describe 'User edits an Event' do
  it 'sees their changes' do
    user = signed_up_user
    sign_in(user)
    date = ArDate.new(year: 4711, month: 1, day: 4)
    event = create(:event, calendar: user.calendars.first, occurred_on: date)

    visit calendar_path(user.calendars.first)
    click_link(event.title)

    form_params = { title: 'A new title' }
    fill_form_and_submit(:event, :update, form_params)

    expect(page).to have_css('li', text: 'A new title')
  end

  it 'does not automatically hide the event' do
    user = signed_up_user
    calendar = user.calendars.first
    sign_in(user)
    date = ArDate.new(year: 4711, month: 1, day: 4)
    event = create(:event, :visible, calendar: calendar, occurred_on: date)

    visit calendar_path(user.calendars.first)
    click_link(event.title)

    checkbox = page.find('#event_hidden')
    expect(checkbox).not_to be_checked
  end

  context 'in a different month' do
    it 'sees their changes' do
      user = signed_up_user
      sign_in(user)
      calendar = user.calendars.first
      calendar.update(current_date: ArDate.new(year: 4711, month: 1, day: 1))
      date = ArDate.new(year: 4711, month: 2, day: 15)
      event = create(:event, calendar: calendar, occurred_on: date)

      visit calendar_path(calendar)

      click_on('next')
      click_on(event.title)
      form_params = { title: 'A new title' }
      fill_form_and_submit(:event, :update, form_params)

      expect(page).to have_css('h2', text: 'Calistril 4711')
      expect(page).to have_css('li', text: 'A new title')
    end
  end
end

RSpec.describe 'User tries to edit an Event with invalid data' do
  it 'sees and error' do
    user = signed_up_user
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

RSpec.describe 'User changes the event date' do
  it 'and is taken to the new event' do
    user = signed_up_user
    sign_in(user)
    calendar = user.calendars.first
    event = create(:event, calendar: calendar)

    visit calendar_path(calendar)
    click_on(event.title)
    fill_in('Date', with: '4700-02-03')
    click_on(I18n.t('helpers.submit.event.update'))

    expect(page).to have_css('h2.month-and-year', text: 'Calistril 4700')
    expect(page).to have_css('ul.events li a', text: event.title)
  end
end
