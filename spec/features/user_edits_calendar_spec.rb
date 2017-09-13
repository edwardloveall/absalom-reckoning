require 'rails_helper'

RSpec.feature 'User edits a Calendar' do
  scenario 'changes the calendar attributes' do
    user = signed_up_user
    calendar = user.calendars.first
    sign_in(user)
    visit calendars_path

    within('aside.sidebar') do
      click_on I18n.t('helpers.action.calendar.index')
    end
    click_on I18n.t('helpers.action.calendar.edit')

    fill_form_and_submit(:calendar, :edit, title: 'New title')

    expect(page).to have_css('aside.sidebar a', text: 'New title')
  end
end
