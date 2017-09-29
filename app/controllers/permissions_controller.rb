class PermissionsController < AuthorizedController
  def create
    invitation = Invitation.find(params[:invitation])
    permission = Permission.new(params_from_invite(invitation))

    if permission.save
      redirect_to calendar_path(permission.calendar)
    end
  end

  private

  def params_from_invite(invitation)
    {
      level: invitation.level,
      user: User.find_by(email: invitation.email),
      calendar: invitation.calendar
    }
  end
end
