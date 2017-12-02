require 'rails_helper'

RSpec.describe 'Permission management' do
  it 'owner sees permissions on a particular calendar' do
    owner = sign_in(signed_up_user)
    calendar = owner.calendars.first
    email = 'hello@example.com'
    invited = signed_up_user(email: email)
    create(:permission, user: invited, calendar: calendar, level: 'editor')

    visit edit_calendar_path(calendar)

    expect(page).to have_css('.permissions li', text: email)
  end

  it 'owner revokes permission on a particular calendar' do
    owner = sign_in(signed_up_user)
    calendar = owner.calendars.first
    email = 'hello@example.com'
    invited = signed_up_user(email: email)
    create(:permission, user: invited, calendar: calendar, level: 'editor')

    visit edit_calendar_path(calendar)

    within('.permissions li') do
      click_on('Revoke')
    end

    expect(current_path).to eq(edit_calendar_path(calendar))
    expect(page).not_to have_css('.permissions li', text: email)
  end

  context 'non-owner tries to revoke a permission' do
    it "straight up can't" do
      owner = signed_up_user
      calendar = owner.calendars.first
      email = 'hello@example.com'
      invited = sign_in(signed_up_user(email: email))
      create(:permission, user: invited, calendar: calendar, level: 'editor')

      visit edit_calendar_path(calendar)

      expect(current_path).to eq(root_path)
    end
  end
end
