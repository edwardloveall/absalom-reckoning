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
end
