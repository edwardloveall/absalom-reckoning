require 'rails_helper'

RSpec.describe CalendarHelper do
  describe '#calendar_actions' do
    it 'returns html for generic calendar actions' do
      result = helper.calendar_actions

      expect(result).to eq <<-HTML.strip_heredoc.strip_html_whitespace
      <ul class="calendar-actions">
        <li><a class="action" href="/calendars/new">New Calendar</a></li>
        <li><a class="action" href="/calendars">Edit Calendars</a></li>
      </ul>
      HTML
    end
  end
end
