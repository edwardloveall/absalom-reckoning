FactoryGirl.define do
  factory :event do
    title 'TPK'
    occurred_on ArDate.new
    calendar

    trait :hidden do
      hidden_at { Time.current }
    end

    trait :visible do
      hidden_at nil
    end
  end
end
