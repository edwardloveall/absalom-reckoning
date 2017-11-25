require 'rails_helper'

RSpec.feature 'User creates a calendar' do
  scenario 'is taken to that calendar' do
    user = signed_up_user
    sign_in(user)
    title = 'Holidays'

    visit calendar_path(user.calendars.first)
    click_on I18n.t('helpers.action.calendar.new')
    fill_form_and_submit(:calendar, title: title)

    calendar = Calendar.find_by(title: title)

    expect(current_path).to eq(calendar_path(calendar))
    expect(page).to have_css('aside a', text: title)
  end

  scenario 'is allowed to add events to it' do
    user = signed_up_user
    sign_in(user)
    title = 'My Calendar'

    visit calendar_path(user.calendars.first)
    click_on I18n.t('helpers.action.calendar.new')
    fill_form_and_submit(:calendar, title: title)
    click_on(title)

    within('.week:nth-of-type(2) .date:nth-of-type(3)') do
      click_link I18n.t('helpers.action.event.new')
    end

    event_params = { title: 'TPK' }
    fill_form_and_submit(:event, event_params)

    within('.week:nth-of-type(2) .date:nth-of-type(3)') do
      expect(page).to have_css('li', text: event_params[:title])
    end
  end
end
