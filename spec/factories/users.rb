FactoryGirl.define do
  factory :user do
    email
    password_digest 'password'
  end
end
