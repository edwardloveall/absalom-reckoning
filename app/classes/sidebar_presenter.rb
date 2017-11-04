class SidebarPresenter < Keynote::Presenter
  presents :user
  use_html_5_tags

  def invitation_link
    if Invitation.pending.where(email: user.email).present?
      link_to('Invitations', invitations_path, class: 'action')
    end
  end

  def calendar_list(for_current:)
    build_html do
      nav class: 'calendar-list' do
        user.calendars.order(:created_at).each do |calendar|
          current = (calendar == for_current).to_s
          a(
            calendar.title,
            href: calendar_path(calendar),
            data: { current: current }
          )
        end
      end
    end
  end

  def calendar_actions
    build_html do
      ul class: 'calendar-actions' do
        li do
          a t('helpers.action.calendar.new'), href: new_calendar_path, class: 'action'
        end
        li do
          a t('helpers.action.calendar.index'), href: calendars_path, class: 'action'
        end
      end
    end
  end

  def session_actions
    build_html do
      ul class: :session do
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
