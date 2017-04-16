FactoryGirl.define do
  factory :event do
    title 'TPK'
    occurred_on ArDate.new
    calendar
  end
end
