require 'rails_helper'

RSpec.describe SidebarPresenter do
  describe '#invitation_link' do
    context 'if the user has any invitations' do
      it 'returns a link to their invitation page' do
        email = 'user@example.com'
        user = create(:user, email: email)
        invitation = create(:invitation, email: email, level: 'editor')
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

  describe '#calendar_list' do
    it 'returns a list of calendars with the current calendar selected' do
      permission = create(:permission, :owner)
      user = permission.user
      selected_calendar = permission.calendar
      other_calendar = create(:permission, :owner, user: user).calendar
      presenter = present(:sidebar, user)

      result = presenter.calendar_list(for_current: selected_calendar)

      expect(result).to eq <<-HTML.strip_heredoc.strip_html_whitespace
        <nav class="calendar-list">
          <a href="/calendars/#{selected_calendar.id}" data-current="true">#{selected_calendar.title}</a>
          <a href="/calendars/#{other_calendar.id}" data-current="false">#{other_calendar.title}</a>
        </nav>
      HTML
    end
  end

  describe '#session_actions' do
    it 'returns html for session related actions' do
      user = create(:user)
      presenter = present(:sidebar, user)

      result = presenter.session_actions

      expect(result).to eq <<-HTML.strip_heredoc.strip_html_whitespace
        <ul class="session">
          <li><a href="">#{user.email}</a></li>
          <li><a rel="nofollow" data-method="delete" href="/session">Sign out</a></li>
        </ul>
      HTML
    end
  end
end
