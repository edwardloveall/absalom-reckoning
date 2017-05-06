class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create], raise: false
  layout 'session', only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = SignUpUser.perform(user_params)

    if @user.valid?
      sign_in(@user)
      redirect_to calendar_path(@user.calendars.first)
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
