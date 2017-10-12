require 'rails_helper'

RSpec.describe SidebarPresenter do
  describe '#invitation_link' do
    context 'if the user has any invitations' do
      it 'returns a link to their invitation page' do
        email = 'user@example.com'
        user = create(:user, email: email)
        invitation = create(:invitation, email: email)
        presenter = present(:sidebar, user)
        html = '<a class="action" href="/invitations">Invitations</a>'

        result = presenter.invitation_link

        expect(result).to eq(html)
      end
    end

    context 'if the user has no invitations' do
      it 'returns nothing' do
        email = 'user@example.com'
        user = create(:user, email: email)
        presenter = present(:sidebar, user)

        result = presenter.invitation_link

        expect(result).to be_nil
      end
    end
  end
end
