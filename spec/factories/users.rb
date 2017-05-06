FactoryGirl.define do
  factory :user do
    email 'user@example.com'
    password_digest 'password'

    after(:create) do |user, _|
      create(:calendar, users: [user])
    end
  end
end
