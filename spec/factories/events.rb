FactoryGirl.define do
  factory :event do
    title 'TPK'
    occurred_on ArDate.new
    calendar
    hidden_at nil
  end
end
