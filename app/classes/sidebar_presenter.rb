class SidebarPresenter < Keynote::Presenter
  presents :user

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
end
