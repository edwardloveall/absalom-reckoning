require 'rails_helper'

RSpec.describe SidebarPresenter do
  describe '#calendar_list' do
    it 'returns a list of calendars with the current calendar selected' do
      permission = create(:permission, :owner)
      user = permission.user
      selected_calendar = permission.calendar
      other_calendar = create(:permission, :owner, user: user).calendar
      presenter = present(:sidebar, user)

      result = presenter.calendar_list(for_current: selected_calendar)

      expect(result).to eq <<-HTML.strip_heredoc.strip_html_whitespace
        <ul class="calendar-list">
          <li data-current="true">
            <a href="/calendars/#{selected_calendar.id}">#{selected_calendar.title}</a>
          </li>
          <li data-current="false">
            <a href="/calendars/#{other_calendar.id}">#{other_calendar.title}</a>
          </li>
        </ul>
      HTML
    end
  end
end
