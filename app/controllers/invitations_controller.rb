class InvitationsController < AuthorizedController
  def create
    @invitation = Invitation.new(invitation_params)
    if @invitation.save
      flash[:success] = t(
        'helpers.messages.invitation.create',
        email: invitation_params[:email]
      )
      redirect_to edit_calendar_path(params[:calendar_id])
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:email, :calendar_id, :owner_id)
  end
end
