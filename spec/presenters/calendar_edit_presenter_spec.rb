require 'rails_helper'

RSpec.describe CalendarEditPresenter do
  describe '#permission_list' do
    it 'returns html for all the permissions' do
      email = 'dudebro17@geocities.com'
      user = create(:user, email: email)
      permission = create(:permission, user: user)
      presenter = present(:calendar_edit, permission.calendar)

      result = Capybara.string(presenter.permission_list)

      expect(result).to have_css('ul.current-permissions')
      expect(result).to have_css('li span.email', text: email)
      expect(result).to have_css(
        'ul.current-permissions a[data-method=delete]',
        text: 'Revoke'
      )
    end
  end

  describe '#invitation_list' do
    it 'returns html for all the invitations' do
      email = 'honeybadger@dontcare.com'
      invitation = create(:invitation, email: email)
      presenter = present(:calendar_edit, invitation.calendar)

      result = Capybara.string(presenter.invitation_list)

      expect(result).to have_css('ul.current-invitations')
      expect(result).to have_css('li span.email', text: email)
      expect(result).to have_css(
        'ul.current-invitations a[data-method=delete]',
        text: 'Delete'
      )
    end
  end
end
