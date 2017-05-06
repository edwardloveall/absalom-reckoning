require 'rails_helper'

RSpec.feature 'User signs in' do
  scenario 'sees email' do
    attributes = { email: 'user@example.com', password: '12345' }
    user = SignUpUser.perform(attributes)

    visit root_path
    click_on 'Sign in'

    within('form') do
      fill_form_and_submit(:session, attributes)
    end

    within 'aside.sidebar' do
      expect(page).to have_css('a', text: user.email)
    end
  end

  context 'with invalid email and password' do
    scenario 'sees sign in form again' do
      attributes = { email: 'no_one@example.com', password: 'wrong' }

      visit root_path
      click_on 'Sign in'

      within('form') do
        fill_form_and_submit(:session, attributes)
      end

      expect(current_path).to eq(session_path)
    end
  end
end
