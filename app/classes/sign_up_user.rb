class SignUpUser
  attr_reader :user_params

  def self.perform(user_params)
    new(user_params).perform
  end

  def initialize(user_params = {})
    @user_params = user_params
  end

  def perform
    user = create_user(user_params)
    ApplicationRecord.transaction do
      create_initial_calendar(user: user)
    end
    user
  rescue ActiveRecord::RecordInvalid
    user
  end

  def create_user(user_params)
    Monban.config.sign_up_service.new(user_params).perform
  end

  def create_initial_calendar(user:)
    calendar = Calendar.create!(title: 'My Campaign')
    Permission.create!(user: user, calendar: calendar, level: 'owner')
    calendar
  end
end
