require 'rails_helper'

RSpec.feature 'Users signs out' do
  scenario 'sees sign in link' do
    user = create(:user)
    sign_in(user)

    visit root_path
    click_on 'Sign out'

    within 'aside.sidebar' do
      expect(page).to have_css('a', text: 'Sign in')
    end
  end
end
