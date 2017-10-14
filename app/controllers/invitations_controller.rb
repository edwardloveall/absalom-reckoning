class InvitationsController < AuthorizedController
  def index
    @invitations = Invitation.pending.where(email: current_user.email)
  end

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

  def destroy
    @calendar = Calendar.find(params[:calendar_id])
    @invitation = @calendar.invitations.find(params[:id])

    if @invitation.destroy
      redirect_to edit_calendar_path(@calendar)
    else
      render :edit
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:email, :level, :calendar_id, :owner_id)
  end
end
