require 'rails_helper'

RSpec.describe 'User edits a Calendar' do
  it 'changes the calendar attributes' do
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

  context 'user is an editor of the calendar' do
    it "can't access the edit screen" do
      title = 'Best Calendar'
      calendar = create(:calendar, title: title)
      user = sign_in(signed_up_user)
      create(:permission, user: user, calendar: calendar, level: 'editor')

      visit root_path
      click_on 'Edit Calendars'

      expect(page).not_to have_css('.calendars li', text: title)

      visit edit_calendar_path(calendar)

      expect(current_path).to eq(root_path)
      error_text = "You don't have permission to do that"
      expect(page).to have_css('.error', text: error_text)
    end
  end
end
