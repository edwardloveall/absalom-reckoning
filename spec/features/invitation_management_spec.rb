require 'rails_helper'

RSpec.feature 'Invitation management' do
  scenario 'user invites anoher user to a calendar' do
    email = 'invited@example.com'
    sign_in(signed_up_user)
    invited = signed_up_user(email: email)
    visit root_path

    click_on 'Edit Calendars'
    click_on 'Edit'
    fill_in 'Email', with: email
    click_on 'Invite'

    flash_text = "Success! #{email} can now accept this invitation."
    expect(page).to have_css('.invitation-list li', text: email)
    expect(page).to have_css('.flashes li', text: flash_text)
  end
end
