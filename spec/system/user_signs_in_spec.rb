require 'rails_helper'

RSpec.describe 'User signs in' do
  it 'sees email' do
    attributes = { email: 'user@example.com', password: '12345' }
    user = signed_up_user(attributes)

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
    it 'sees sign in form again' do
      attributes = { email: 'no_one@example.com', password: 'wrong' }

      visit root_path
      click_on 'Sign in'

      within('form') do
        fill_form_and_submit(:session, attributes)
      end

      expect(current_path).to eq(session_path)
    end
  end

  context 'user is already signed in' do
    it 'is taken to their calendar' do
      attributes = { email: 'user@example.com', password: '12345' }
      user = signed_up_user(attributes)
      calendar = user.calendars.first

      visit new_session_path
      within('form') do
        fill_form_and_submit(:session, attributes)
      end

      expect(current_path).to eq(calendar_path(calendar))

      visit new_session_path

      expect(current_path).to eq(calendar_path(calendar))
    end
  end
end
