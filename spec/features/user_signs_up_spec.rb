require 'rails_helper'

RSpec.feature 'User signs up' do
  scenario 'sees email' do
    attributes = attributes_for(:user)

    visit root_path
    click_on 'Sign up'

    within('form') do
      fill_form_and_submit(:user, attributes)
    end

    within 'aside.sidebar' do
      expect(page).to have_css('a', text: attributes[:email])
    end
  end

  context 'with invalid user data' do
    scenario 'sees error' do
      attributes = { email: '', password: '' }

      visit root_path
      click_on 'Sign up'

      within('form') do
        fill_form_and_submit(:user, attributes)
      end

      within('form') do
        expect(page).to have_text('prevented your account from being created')
      end
    end
  end
end
