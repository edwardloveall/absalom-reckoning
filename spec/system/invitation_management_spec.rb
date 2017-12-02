require 'rails_helper'

RSpec.describe 'Invitation management' do
  it 'user invites another user to a calendar' do
    email = 'invited@example.com'
    calendar_title = 'Awesome Calendar'
    owner = sign_in(signed_up_user)
    calendar = owner.calendars.first
    calendar.update(title: calendar_title)
    invited = signed_up_user(email: email)
    visit root_path

    click_on 'Edit Calendars'
    click_on 'Edit'
    fill_in 'Email', with: email
    select 'Viewer', from: 'Level'
    click_on 'Send Invitation'

    flash_text = "Success! #{email} can now accept this invitation."
    expect(page).to have_css('.current-invitations li', text: email)
    expect(page).to have_css('.flashes li', text: flash_text)

    click_on 'Sign out'

    sign_in(invited)
    visit root_path

    click_on 'Invitations'
    within('ul.current-invitations li:first-child') do
      click_on 'Accept'
    end
    click_on calendar_title

    within('.sidebar') do
      expect(page).to have_css('a[data-current="true"]', text: calendar_title)
    end
  end

  it 'user deletes an invite' do
    email = 'invited@example.com'
    invited = sign_in(signed_up_user(email: email))
    owner = signed_up_user
    calendar_title = 'Awesome Calendar'
    calendar = owner.calendars.first
    calendar.update(title: calendar_title)
    invitation = create(
      :invitation,
      email: email,
      owner: owner,
      calendar: calendar,
      level: 'editor'
    )

    visit root_path
    click_on 'Invitations'

    within('ul.current-invitations') do
      expect(page).to have_css('li', text: calendar_title)
    end

    click_on 'Sign out'

    sign_in(owner)
    visit root_path
    click_on 'Edit Calendars'
    click_on 'Edit'
    within('.current-invitations') do
      find(:css, '.delete').click
    end

    expect(page).not_to have_css('li', text: email)
  end

  it 'invitation is hidden after a permission is created' do
    owner = signed_up_user
    calendar = owner.calendars.first
    email = 'hello@example.com'
    user = sign_in(signed_up_user(email: email))
    invitation = create(
      :invitation,
      email: email,
      owner: owner,
      calendar: calendar
    )

    visit root_path
    click_on 'Invitations'
    click_on 'Accept'
    visit invitations_path

    expect(page).not_to have_css('.sidebar a', text: 'Invitations')
    expect(page).to have_css('.current-invitations li', count: 0)

    sign_in(owner)
    visit edit_calendar_path(calendar)

    expect(page).to have_css('.current-invitations li', text: email, count: 0)
  end
end
