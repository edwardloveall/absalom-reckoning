require 'rails_helper'

RSpec.describe 'User navigates to a calendar' do
  it 'by clicking links in the sidebar' do
    user = signed_up_user
    sign_in(user)
    calendar = create(:calendar)
    create(:permission, :owner, user: user, calendar: calendar)

    visit calendars_path
    click_on calendar.title

    expect(current_path).to eq(calendar_path(calendar))
  end

  it 'is taken to "today" on the calendar' do
    user = signed_up_user
    sign_in(user)
    calendar = user.calendars.first
    current_date = ArDate.new(year: 5, month: 3, day: 1)
    calendar.update(current_date: current_date)

    visit calendars_path
    click_on calendar.title

    within('main') do
      expect(page).to have_css('h2', text: 'Pharast 5')
    end
  end
end
