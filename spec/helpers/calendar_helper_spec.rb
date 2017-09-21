require 'rails_helper'

RSpec.describe CalendarHelper do
  describe '#calendar_actions' do
    it 'returns html for generic calendar actions' do
      result = helper.calendar_actions

      expect(result).to eq <<-HTML.strip_heredoc.strip_html_whitespace
      <nav class="calendar-actions">
        <a class="action" href="/calendars/new">New Calendar</a>
        <a class="action" href="/calendars">Edit Calendars</a>
      </nav>
      HTML
    end
  end
end
