class PasswordResetsController < ApplicationController
  def new
    @password_reset = PasswordReset.new
  end

  def create
    user = User.find_by(email: params[:password_reset][:email])
    if user
      password_reset = PasswordReset.create(user: user)
      PasswordResetMailer.change_password(password_reset).deliver_now
    end
  end

  def edit
    @password_reset = find_password_reset
    @user = @password_reset.user
  end

  def update
    @password_reset = find_password_reset
    @user = @password_reset.user

    reset_password(@user, params[:password_reset][:password])

    if @user.save
      sign_in @user
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def find_password_reset
    PasswordReset.find_by!(token: params[:id], user_id: params[:user_id])
  end
end
