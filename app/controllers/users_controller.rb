class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create], raise: false
  layout 'session', only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = sign_up(user_params)

    if @user.valid?
      calendar = Calendar.create(title: 'My Campaign')
      Permission.create(user: @user, calendar: calendar, level: 'owner')
      sign_in(@user)
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
