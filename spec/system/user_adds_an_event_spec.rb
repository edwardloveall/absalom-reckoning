require 'rails_helper'

RSpec.describe 'User adds an Event' do
  it 'sees their event' do
    user = signed_up_user
    sign_in(user)

    visit calendar_path(user.calendars.first)
    within('.week:nth-of-type(2) .date:nth-of-type(3)') do
      click_link('New Event')
    end

    form_params = { title: 'TPK' }
    fill_form_and_submit(:event, form_params)

    within('.week:nth-of-type(2) .date:nth-of-type(3)') do
      expect(page).to have_css('li', text: 'TPK')
    end
  end

  context 'on a different month' do
    it 'is taken back to to that month' do
      user = signed_up_user
      sign_in(user)

      visit calendar_path(user.calendars.first)
      click_on('next')
      within('.week:nth-of-type(2) .date:nth-of-type(3)') do
        click_link('New Event')
      end

      form_params = { title: 'TPK' }
      fill_form_and_submit(:event, form_params)

      expect(page).to have_css('h2', text: 'Calistril 4711')
      within('.week:nth-of-type(2) .date:nth-of-type(3)') do
        expect(page).to have_css('li', text: 'TPK')
      end
    end
  end
end

RSpec.describe 'User tries to add an event with invalid data' do
  it 'sees and error' do
    user = signed_up_user
    sign_in(user)

    visit calendar_path(user.calendars.first)
    within('.week:nth-of-type(2) .date:nth-of-type(3)') do
      click_link('New Event')
    end

    form_params = { title: '' }
    fill_form_and_submit(:event, form_params)

    within('.event_title') do
      expect(page).to have_css('span', text: "can't be blank")
    end
  end
end

RSpec.describe 'User decides not to add an event' do
  it 'and is redirected back to their calendar' do
    user = signed_up_user
    sign_in(user)

    visit calendar_path(user.calendars.first)
    click_on('next')
    within('.week:nth-of-type(2) .date:nth-of-type(3)') do
      click_link('New Event')
    end

    click_on('Cancel')

    path_with_date = calendar_path(user.calendars.first, date: '4711-02-08')
    expect(page).to have_current_path(path_with_date)
    expect(page).to have_css('h2', text: 'Calistril 4711')
  end
end

RSpec.describe 'User sets an event date manually' do
  it 'creates an event on that date' do
    user = signed_up_user
    sign_in(user)
    form_params = { title: 'TPK', date: '4700-02-03' }

    visit calendar_path(user.calendars.first)
    within('.week:nth-of-type(2) .date:nth-of-type(3)') do
      click_link('New Event')
    end
    fill_form_and_submit(:event, form_params)

    expect(page).to have_css('h2.month-and-year', text: 'Calistril 4700')
    expect(page).to have_css('ul.events li a', text: 'TPK')
  end
end
