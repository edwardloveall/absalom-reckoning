class PermissionsController < AuthorizedController
  def create
    invitation = Invitation.find(params[:invitation_id])
    permission = Permission.new(params_from_invite(invitation))

    if permission.save
      invitation.accept!
      redirect_to calendar_path(permission.calendar)
    end
  end

  def destroy
    calendar = current_user.calendars.find(params[:calendar_id])
    permission = calendar.permissions.find(params[:id])
    permission.destroy

    redirect_to edit_calendar_path(calendar)
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
