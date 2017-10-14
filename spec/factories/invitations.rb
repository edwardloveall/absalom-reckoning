FactoryGirl.define do
  factory :invitation do
    email
    calendar
    association :owner, factory: :user
    level 'editor'
  end
end
