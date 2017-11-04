require 'rails_helper'

RSpec.describe UserPresenter do
  describe '#session_actions' do
    it 'returns html for session related actions' do
      user = create(:user)
      presenter = present(user)

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
