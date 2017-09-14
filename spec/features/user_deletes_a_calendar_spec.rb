require 'rails_helper'

RSpec.feature 'User deletes a calendar' do
  scenario 'is taken back to their list of calendars' do
    user = sign_in(signed_up_user)
    calendar = user.calendars.first

    visit(calendar_path(calendar))

    expect(page).to have_css('.sidebar ul.calendar-list li', count: 1)

    within('.sidebar') do
      click_on t('helpers.action.calendar.index')
    end
    click_on t('helpers.action.calendar.edit')
    click_on t('helpers.action.calendar.destroy')

    expect(current_path).to eq(calendars_path)
    expect(page).to have_css('.sidebar ul.calendar-list li', count: 0)
  end
end
