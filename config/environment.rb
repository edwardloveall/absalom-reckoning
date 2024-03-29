# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  user_name: ENV['SENDGRID_USERNAME'],
  password: ENV['SENDGRID_PASSWORD'],
  domain: Rails.application.config.action_mailer.default_url_options[:host],
  address: 'smtp.sendgrid.net',
  port: 587,
  authentication: :plain,
  enable_starttls_auto: true
}

if ENV['EMAIL_RECIPIENTS'].present?
  Mail.register_interceptor(RecipientInterceptor.new(ENV['EMAIL_RECIPIENTS']))
end
