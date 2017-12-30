class PasswordResetMailer < ActionMailer::Base
  default from: 'noreply@absalomreckoning.com'

  def change_password(password_reset)
    @password_reset = password_reset
    @user = password_reset.user

    mail(
      to: @user.email,
      subject: t('mail.password_reset.subject')
    )
  end
end
