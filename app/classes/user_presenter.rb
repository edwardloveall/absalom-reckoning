class UserPresenter < Keynote::Presenter
  presents :user
  use_html_5_tags

  def calendar_list(for_current:)
    build_html do
      nav class: 'calendar-list' do
        user.calendars.each do |calendar|
          current = (calendar == for_current).to_s
          a calendar.title, href: calendar_path(calendar), data: { current: current }
        end
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
end
