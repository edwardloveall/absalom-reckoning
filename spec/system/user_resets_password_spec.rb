require 'rails_helper'

RSpec.describe 'Users resets their password' do
  it 'sends an email to the user' do
    email = 'user@example.com'
    user = signed_up_user(email: email)

    visit root_path
    click_on 'Sign in'
    click_on 'Reset Password'
    fill_form_and_submit(:password_reset, email: email)

    deliveries = ActionMailer::Base.deliveries
    message = deliveries.last

    expect(message.to).to eq([email])
    expect(message.from).to eq(['noreply@absalomreckoning.com'])
    expect(message.subject).to eq('Absalom Reckoning Password Reset')
    expect(message.body).to include("/users/#{user.id}/password_resets/")
  end

  it 'user can reset their password with a reset link' do
    new_password = 'new-password'
    email = 'user@example.com'
    old_attributes = { email: email, password: '12345' }
    new_attributes = { email: email, password: new_password }
    user = signed_up_user(old_attributes)
    reset = PasswordReset.create(user: user)

    visit edit_user_password_reset_path(user, reset)
    fill_form_and_submit(:password_reset, :edit, password: new_password)

    expect(current_path).to eq(root_path)

    click_on 'Sign out'
    click_on 'Sign in'
    within('form') do
      fill_form_and_submit(:session, new_attributes)
    end

    within 'aside.sidebar' do
      expect(page).to have_css('a', text: user.email)
    end
  end
end
