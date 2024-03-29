class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create], raise: false

  def new
    if signed_in?
      redirect_to calendar_path(current_user.calendars.first)
    end
  end

  def create
    user = authenticate_session(session_params)

    if sign_in(user)
      redirect_to calendar_path(user.calendars.first)
    else
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
