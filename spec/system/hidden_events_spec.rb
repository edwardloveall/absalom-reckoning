require 'rails_helper'

RSpec.describe 'User creates a hidden event' do
  context 'user is the calendar owner' do
    it 'cannot be seen by an editor' do
      owner = signed_up_user
      editor = signed_up_user
      calendar = owner.calendars.first
      create(:permission, :editor, calendar: calendar, user: editor)

      sign_in(owner)
      visit calendar_path(calendar)
      within('.week:nth-of-type(1) .date:nth-of-type(7)') do
        click_on 'New Event'
      end
      form_params = { title: 'TPK', hidden: true }
      fill_form_and_submit(:event, form_params)

      within('.week:nth-of-type(1) .date:nth-of-type(7)') do
        expect(page).to have_css('li', text: 'TPK')
      end

      sign_in(editor)
      visit calendar_path(calendar)

      within('.week:nth-of-type(1) .date:nth-of-type(7)') do
        expect(page).not_to have_css('li', text: 'TPK')
      end
    end
  end

  context 'user is an editor' do
    it 'can not see the hidden option' do
      editor = signed_up_user
      permission = create(:permission, :editor, user: editor)
      calendar = permission.calendar

      sign_in(editor)
      visit calendar_path(calendar)
      within('.week:nth-of-type(1) .date:nth-of-type(7)') do
        click_on 'New Event'
      end

      within('form') do
        expect(page).not_to have_css('input#event_hidden')
      end
    end
  end
end


    end
  end
end
