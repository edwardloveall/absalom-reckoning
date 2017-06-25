FactoryGirl.define do
  factory :permission do
    user
    calendar

    trait :owner do
      level 'owner'
    end

    trait :editor do
      level 'editor'
    end

    trait :viewer do
      level 'viewer'
    end
  end
end
