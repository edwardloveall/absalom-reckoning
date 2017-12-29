class SignUpUser
  def self.perform(user_params)
    new.perform(user_params)
  end

  def perform(user_params)
    user = create_user(user_params)
    create_initial_calendar(user: user)
    user
  end

  def create_user(user_params)
    Oath.config.sign_up_service.new(user_params).perform
  end

  def create_initial_calendar(user:)
    calendar = Calendar.create(title: 'My Campaign')
    Permission.create(user: user, calendar: calendar, level: 'owner')
    calendar
  end
end
