require 'rails_helper'

RSpec.describe 'owner can re-invite a user' do
  it 'shows their permission in the calendar settings' do
    owner = signed_up_user
    email = 'foo@example.com'
    editor = signed_up_user(email: email)
    calendar = owner.calendars.first

    sign_in(owner)
    visit edit_calendar_path(calendar)
    fill_in 'Email', with: email
    select 'Editor', from: 'Level'
    click_on 'Send Invitation'
    click_on 'Sign out'

    sign_in(editor)
    visit root_path
    click_on 'Invitations'
    click_on 'Accept'
    click_on 'Sign out'

    sign_in(owner)
    visit edit_calendar_path(calendar)
    click_on 'Revoke'
    fill_in 'Email', with: email
    select 'Editor', from: 'Level'
    click_on 'Send Invitation'

    expect(page).to have_css('.current-invitations .email', text: email)
  end
end
