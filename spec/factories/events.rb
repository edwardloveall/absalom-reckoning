FactoryGirl.define do
  factory :event do
    title 'TPK'
    occurred_on ArDate.new
    calendar
    hidden_at nil

    trait :hidden do
      hidden_at { Time.current }
    end

    trait :not_hidden do
      hidden_at nil
    end
  end
end
