require 'rails_helper'

RSpec.describe CalendarPresenter do
  describe '#next_month_link' do
    it 'returns a link to the next month' do
      calendar = build(:calendar, id: 1)
      origin_date = ArDate.new(year: 1, month: 1, day: 1)
      presenter = present(calendar)
      presenter.origin_date = origin_date
      date_string = '1-02-01'
      html = "<a class=\"next\" href=\"/calendars/1?date=1-02-01\">next</a>"

      expect(presenter.next_month_link).to eq(html)
    end
  end

  describe '#previous_month_link' do
    it 'returns a link to the previous month' do
      calendar = build(:calendar, id: 1)
      origin_date = ArDate.new(year: 1, month: 2, day: 1)
      presenter = present(calendar)
      presenter.origin_date = origin_date
      html = "<a class=\"previous\" href=\"/calendars/1?date=1-01-01\">previous</a>"

      expect(presenter.previous_month_link).to eq(html)
    end
  end

  describe '#month_and_year' do
    it 'returns the month name and year for the origin_date' do
      calendar = create(:calendar)
      origin_date = ArDate.new(year: 1000, month: 6, day: 20)
      presenter = present(calendar)
      presenter.origin_date = origin_date

      html = '<h2 class="month-and-year">Sarenith 1000</h2>'

      expect(presenter.month_and_year).to eq(html)
    end
  end

  describe '#day_names_header' do
    it 'displays a header of all the week days in divs' do
      presenter = present(Calendar.new)
      html = <<~HTML.strip_html_whitespace
      <header>
        <div>Moonday</div>
        <div>Toilday</div>
        <div>Wealday</div>
        <div>Oathday</div>
        <div>Fireday</div>
        <div>Starday</div>
        <div>Sunday</div>
      </header>
      HTML

      expect(presenter.day_names_header).to eq(html)
    end
  end

  describe '#calendar_weeks' do
    it 'yields each week' do
      current_date = ArDate.new(year: 4711, month: 1, day: 4)
      calendar = build(:calendar, current_date: current_date)
      presenter = present(calendar)
      presenter.origin_date = ArDate.new(year: 4711, month: 1, day: 1)
      weeks = []
      weeks << (
        ArDate.new(year: 4710, month: 12, day: 26)..
        ArDate.new(year: 4711, month: 1, day: 1)
      ).to_a
      weeks << (
        ArDate.new(year: 4711, month: 1, day: 2)..
        ArDate.new(year: 4711, month: 1, day: 8)
      ).to_a
      weeks << (
        ArDate.new(year: 4711, month: 1, day: 9)..
        ArDate.new(year: 4711, month: 1, day: 15)
      ).to_a
      weeks << (
        ArDate.new(year: 4711, month: 1, day: 16)..
        ArDate.new(year: 4711, month: 1, day: 22)
      ).to_a
      weeks << (
        ArDate.new(year: 4711, month: 1, day: 23)..
        ArDate.new(year: 4711, month: 1, day: 29)
      ).to_a
      weeks << (
        ArDate.new(year: 4711, month: 1, day: 30)..
        ArDate.new(year: 4711, month: 2, day: 5)
      ).to_a
      week_enumerator = weeks.to_enum

      expect do |block|
        presenter.calendar_weeks(&block)
      end.to yield_control.exactly(6).times
      presenter.calendar_weeks do |week|
        expect(week).to match_array(week_enumerator.next)
      end
    end
  end

  describe '#week_dates' do
    it 'yields each date within the week' do
      calendar = build(:calendar)
      presenter = present(calendar)
      week = (
        ArDate.new(year: 4711, month: 1, day: 1)..
        ArDate.new(year: 4711, month: 1, day: 7)
      ).to_a
      date_enumerator = week.to_enum

      expect do |block|
        presenter.week_dates(within: week, &block)
      end.to yield_control.exactly(7).times
      presenter.week_dates(within: week) do |date|
        expect(date).to eq(date_enumerator.next)
      end
    end
  end

  describe '#date_classes' do
    context 'if the day is a normal day inside the origin_date month' do
      it 'returns "date" class' do
        origin_date = ArDate.new(year: 4711, month: 1, day: 3)
        other_date = ArDate.new(year: 4711, month: 1, day: 4)
        calendar = build(:calendar)
        presenter = present(calendar)
        presenter.origin_date = origin_date

        result = presenter.date_classes(other_date)

        expect(result).to eq('date')
      end

      context 'and the date matches the current_date on the calendar' do
        it 'returns "date today"' do
          origin_date = ArDate.new(year: 4711, month: 1, day: 3)
          current_date = ArDate.new(year: 4711, month: 1, day: 7)
          calendar = build(:calendar, current_date: current_date)
          presenter = present(calendar)
          presenter.origin_date = origin_date

          result = presenter.date_classes(current_date)

          expect(result).to eq('date today')
        end
      end
    end

    context 'if the day is a normal day inside the origin_date month' do
      it 'returns "date not-month"' do
        origin_date = ArDate.new(year: 4711, month: 1, day: 3)
        other_date = ArDate.new(year: 4710, month: 12, day: 30)
        calendar = build(:calendar, )
        presenter = present(calendar)
        presenter.origin_date = origin_date

        result = presenter.date_classes(other_date)

        expect(result).to eq('date not-month')
      end

      context 'and the date matches the origin_date on the presenter' do
        it 'returns "date today not-month"' do
          origin_date = ArDate.new(year: 4711, month: 1, day: 3)
          current_date = ArDate.new(year: 4710, month: 12, day: 30)
          calendar = build(:calendar, current_date: current_date)
          presenter = present(calendar)
          presenter.origin_date = origin_date

          result = presenter.date_classes(current_date)

          expect(result).to eq('date today not-month')
        end
      end
    end
  end

  describe '#today_action' do
    context 'if the day matches the calendar current_date' do
      it 'returns a span with "Today"' do
        current_date = ArDate.new(year: 4711, month: 1, day: 3)
        calendar = build(:calendar, current_date: current_date)
        presenter = present(calendar)
        html = '<span class="today">Today</span>'

        result = presenter.today_action(on: current_date)

        expect(result).to eq(html)
      end
    end

    context 'if the day does not match the calendars current_date' do
      context 'and the user can edit the calendar' do
        it 'returns a link to set the current date' do
          current_date = ArDate.new(year: 4711, month: 1, day: 3)
          other_date = ArDate.new(year: 4711, month: 1, day: 13)
          calendar = build(:calendar, current_date: current_date, id: 1)
          user = build(:user)
          allow(user).to receive(:can_edit?).and_return(true)
          presenter = present(calendar)
          presenter.current_user = user
          html = <<~HTML.strip_html_whitespace
            <a class="set-today" rel="nofollow" data-method="patch" href="/calendars/1/current_date?current_date=4711-01-13">Set Today</a>
          HTML

          result = presenter.today_action(on: other_date)

          expect(result).to eq(html)
        end
      end

      context 'and the user is unable to edit the calendar' do
        it 'returns a link to set the current date' do
          current_date = ArDate.new(year: 4711, month: 1, day: 3)
          other_date = ArDate.new(year: 4711, month: 1, day: 13)
          calendar = build(:calendar, current_date: current_date, id: 1)
          user = build(:user)
          allow(user).to receive(:can_edit?).and_return(false)
          presenter = present(calendar)
          presenter.current_user = user

          result = presenter.today_action(on: other_date)

          expect(result).to be_nil
        end
      end
    end
  end

  describe '#events' do
    context 'if the user can edit the calendar' do
      it 'returns a list of event links for a particular date' do
        current_date = ArDate.new(year: 4711, month: 1, day: 3)
        other_date = ArDate.new(year: 4711, month: 1, day: 13)
        calendar = create(:calendar)
        event = calendar.events.create(title: 'Yay', occurred_on: current_date)
        calendar.events.create(title: 'Boo', occurred_on: other_date)
        user = build(:user)
        allow(user).to receive(:can_edit?).and_return(true)
        presenter = present(calendar)
        presenter.current_user = user
        html = <<~HTML.strip_html_whitespace
        <ul class="events">
          <li>
            <a href="/calendars/#{calendar.id}/events/#{event.id}/edit">Yay</a>
          </li>
        </ul>
        HTML

        result = presenter.events(on: current_date)

        expect(result).to eq(html)
      end
    end
    context 'if the user can not edit the calendar' do
      it 'returns a list of event spans for a particular date' do
        current_date = ArDate.new(year: 4711, month: 1, day: 3)
        other_date = ArDate.new(year: 4711, month: 1, day: 13)
        calendar = create(:calendar)
        event = calendar.events.create(title: 'Yay', occurred_on: current_date)
        calendar.events.create(title: 'Boo', occurred_on: other_date)
        user = build(:user)
        allow(user).to receive(:can_edit?).and_return(false)
        presenter = present(calendar)
        presenter.current_user = user
        html = <<~HTML.strip_html_whitespace
        <ul class="events">
          <li><span>Yay</span></li>
        </ul>
        HTML

        result = presenter.events(on: current_date)

        expect(result).to eq(html)
      end
    end

    context 'if there are no events' do
      it 'returns an empty list' do
        calendar = build(:calendar)
        presenter = present(calendar)
        some_date = ArDate.new(year: 4711, month: 1, day: 3)
        html = '<ul class="events"></ul>'

        result = presenter.events(on: some_date)

        expect(result).to eq(html)
      end
    end
  end

  describe '#new_event_action' do
    context 'if the user can edit the calendar' do
      it 'returns the new event action' do
        date = ArDateParser.from_day_number(1719749)
        calendar = build(:calendar, id: 1)
        user = build(:user)
        presenter = present(calendar)
        presenter.current_user = user
        allow(user).to receive(:can_edit?).and_return(true)
        html = <<~HTML.strip_html_whitespace
          <a href="/calendars/1/events/new?occurred_on=1719749" class="new-event">New Event</a>
        HTML

        result = presenter.new_event_action(on: date)

        expect(result).to eq(html)
      end
    end

    context 'if the user can not edit the calendar' do
      it 'returns nil' do
        date = ArDate.new
        calendar = build(:calendar)
        user = build(:user)
        presenter = present(calendar)
        presenter.current_user = user
        allow(user).to receive(:can_edit?).and_return(false)

        result = presenter.new_event_action(on: date)

        expect(result).to be_nil
      end
    end
  end
end
