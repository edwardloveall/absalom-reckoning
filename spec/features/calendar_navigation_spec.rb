require 'rails_helper'

RSpec.feature 'User navigates to a calendar' do
  scenario 'by clicking links in the sidebar' do
    user = signed_up_user
    sign_in(user)
    calendar = create(:calendar)
    create(:permission, :owner, user: user, calendar: calendar)

    visit calendars_path
    click_on calendar.title

    expect(current_path).to eq(calendar_path(calendar))
  end

  scenario 'is taken to the month that they edited last' do
    user = signed_up_user
    sign_in(user)
    calendar = user.calendars.first

    visit calendars_path
    click_on calendar.title
    click_on('next')
    month_name = find('main h2').text
    within('.week:nth-of-type(2) .day:nth-of-type(3)') do
      click_link('New Event')
    end
    fill_form_and_submit(:event, title: 'TPK')

    within('.sidebar') do
      click_on calendar.title
    end

    within('main') do
      expect(page).to have_css('h2', text: month_name)
    end
  end
end
