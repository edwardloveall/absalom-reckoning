class SidebarPresenter < Keynote::Presenter
  presents :user
  use_html_5_tags

  def calendar_list(for_current:)
    build_html do
      ul class: 'calendar-list' do
        user.calendars.each do |calendar|
          current = (calendar == for_current).to_s
          li data: { current: current } do
            link_to calendar.title, calendar_path(calendar)
          end
        end
      end
    end
  end

  def calendar_actions
    build_html do
      nav class: 'calendar-actions' do
        a.action t('helpers.action.calendar.new'), href: new_calendar_path
        a.action t('helpers.action.calendar.index'), href: calendars_path
      end
    end
  end

  def session_actions
    build_html do
      nav class: :session do
        ul do
          li { link_to user.email, '' }
          li do
            link_to(
              t('helpers.submit.session.destroy'),
              session_path,
              method: :delete
            )
          end
        end
      end
    end
  end

  def signed_out_actions
    build_html do
      nav class: 'signed-out' do
        a.action t('helpers.submit.session.create'), href: new_session_path
        a.action t('helpers.submit.user.create'), href: new_user_path
      end
    end
  end
end
