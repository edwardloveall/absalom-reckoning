class CalendarEditPresenter < Keynote::Presenter
  presents :calendar

  def permission_list
    build_html do
      ul class: 'current-permissions' do
        permissions.each do |permission|
          li do
            span.email permission.user.email
            a t('helpers.submit.permission.destroy'),
              href: calendar_permission_path(calendar, permission),
              data: { method: :delete },
              class: 'delete action'
          end
        end
      end
    end
  end

  def invitation_list
    return nil if invitations.empty?
    build_html do
      ul class: 'current-invitations' do
        invitations.each do |invitation|
          li do
            span.email invitation.email
            a t('helpers.submit.invitation.destroy'),
              href: calendar_invitation_path(calendar, invitation),
              data: { method: :delete },
              class: 'delete action'
          end
        end
      end
    end
  end

  private

  def invitations
    @_invitations ||= calendar.invitations.pending
  end

  def permissions
    @_permissions ||= calendar.
      permissions.
      where(level: Permission::INVITATION_LEVELS)
  end
end
